import aws_cdk.aws_ecr as ecr
import aws_cdk.aws_codebuild as cb
import aws_cdk.aws_codecommit as cc
import aws_cdk.aws_codepipeline as cp
import aws_cdk.aws_codepipeline_actions as cpa
import aws_cdk.aws_iam as iam
from aws_cdk import Stack, Duration

class HumusBuildStack(Stack):
    def __init__(self, 
        *args, **kwargs
    ):
        super().__init__(*args, **kwargs)

        git_repo = cc.Repository(
            self, "CodeCommitRepository",
            repository_name="humus"
        )

        ecr_repo = ecr.Repository(
            self, "ECRRepository", 
            repository_name="humus",
            lifecycle_rules=[
                ecr.LifecycleRule(
                    tag_status=ecr.TagStatus.UNTAGGED, 
                    max_image_age=Duration.days(3),
                    description="delete untagged images after 3 days"
                ),
            ]
        )

        role: iam.Role = iam.Role(
            self, "IamRoleBuild", 
            role_name="humus-codebuild",
            assumed_by=iam.CompositePrincipal(
                iam.ServicePrincipal(service="codepipeline.amazonaws.com"),
                iam.ServicePrincipal(service="codebuild.amazonaws.com"),
            ),
            managed_policies=[
                iam.ManagedPolicy.from_managed_policy_arn(self, arn, managed_policy_arn=arn)
                for arn in [
                    "arn:aws:iam::aws:policy/AWSCloudFormationFullAccess",
                    "arn:aws:iam::aws:policy/AWSCodeBuildAdminAccess",
                    "arn:aws:iam::aws:policy/AWSCodeCommitPowerUser",
                    "arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess",
                    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess",
                    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
                    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
                    "arn:aws:iam::aws:policy/AmazonSSMFullAccess",
                    "arn:aws:iam::aws:policy/CloudWatchFullAccess",
                    "arn:aws:iam::aws:policy/IAMFullAccess",
                ]
            ]
        )
        role.add_to_policy(iam.PolicyStatement(
            actions=["sts:AssumeRole"],
            resources=["arn:aws:iam::*:role/cdk-*"]
        ))

        project_amd64 = cb.PipelineProject(
            self, 
            f'CodeBuildProjectAmd64', 
            project_name=f'humus-amd64',
            environment=cb.BuildEnvironment(
                build_image=cb.LinuxBuildImage.STANDARD_7_0,
                compute_type=cb.ComputeType.SMALL,
                privileged=True
            ),
            environment_variables={
                "ECR_REPO": cb.BuildEnvironmentVariable(value=ecr_repo.repository_uri)
            },
            role=role,  # type: ignore
            build_spec=cb.BuildSpec.from_source_filename("cdk/buildspec.yml")
        )

        project_arm64 = cb.PipelineProject(
            self, 
            f'CodeBuildProjectArm64', 
            project_name=f'humus-arm64',
            environment=cb.BuildEnvironment(
                build_image=cb.LinuxBuildImage.AMAZON_LINUX_2_ARM_3,
                compute_type=cb.ComputeType.SMALL,
                privileged=True
            ),
            environment_variables={
                "ECR_REPO": cb.BuildEnvironmentVariable(value=ecr_repo.repository_uri)
            },
            role=role,  # type: ignore
            build_spec=cb.BuildSpec.from_source_filename("cdk/buildspec.yml")
        )

        source = cp.Artifact(artifact_name="humus")

        pipeline = cp.Pipeline(
            self, 'CodePipeline',
            pipeline_name='humus',
            role=role,  # type: ignore
            stages=[
                cp.StageProps(stage_name="source", actions=[
                    cpa.CodeCommitSourceAction(
                        repository=git_repo,
                        code_build_clone_output=True,
                        action_name="humus",
                        output=source,
                        branch='main',
                        trigger=cpa.CodeCommitTrigger.EVENTS,
                        role=role,  # type: ignore
                    )
                ]),
                cp.StageProps(stage_name="build", actions=[
                    cpa.CodeBuildAction(
                        action_name="humus-amd64", 
                        input=source, 
                        project=project_amd64,  # type: ignore
                        role=role,  # type: ignore
                        environment_variables={
                            'ACTION': cb.BuildEnvironmentVariable(value="build-amd64", type=cb.BuildEnvironmentVariableType.PLAINTEXT)
                        },
                    ),
                    cpa.CodeBuildAction(
                        action_name="humus-arm64", 
                        input=source, 
                        project=project_arm64,  # type: ignore
                        role=role,  # type: ignore
                        environment_variables={
                            'ACTION': cb.BuildEnvironmentVariable(value="build-arm64", type=cb.BuildEnvironmentVariableType.PLAINTEXT)
                        },
                    ) 
                ]),
                cp.StageProps(stage_name="deploy", actions=[
                    cpa.CodeBuildAction(
                        action_name="deploy", 
                        input=source, 
                        project=project_amd64,  # type: ignore
                        role=role,  # type: ignore
                        environment_variables={
                            'ACTION': cb.BuildEnvironmentVariable(value="deploy", type=cb.BuildEnvironmentVariableType.PLAINTEXT)
                        },
                    ),
                ]),
            ]
        )
