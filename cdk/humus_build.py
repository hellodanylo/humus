import aws_cdk.aws_ecr as ecr
import aws_cdk.aws_codebuild as cb
import aws_cdk.aws_codecommit as cc
import aws_cdk.aws_codepipeline as cp
import aws_cdk.aws_codepipeline_actions as cpa
import aws_cdk.aws_iam as iam
from aws_cdk import Stack

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
            repository_name="humus"
        )

        role = iam.Role(
            self, "IamRoleBuild", 
            role_name="humus-codebuild",
            assumed_by=iam.CompositePrincipal(
                iam.ServicePrincipal(service="codepipeline.amazonaws.com"),
                iam.ServicePrincipal(service="codebuild.amazonaws.com"),
            ),
            managed_policies=[
                iam.ManagedPolicy.from_managed_policy_arn(self, arn, managed_policy_arn=arn)
                for arn in [
                    "arn:aws:iam::aws:policy/AWSCodeBuildAdminAccess",
                    "arn:aws:iam::aws:policy/AWSCodeCommitPowerUser",
                    "arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess",
                    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess",
                    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
                    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
                    "arn:aws:iam::aws:policy/CloudWatchFullAccess",
                ]
            ]
        )

        project = cb.PipelineProject(
            self, 
            f'CodeBuildProject', 
            project_name=f'humus',
            environment=cb.BuildEnvironment(
                build_image=cb.LinuxBuildImage.STANDARD_6_0,
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
                        trigger=cpa.CodeCommitTrigger.POLL,
                        role=role,  # type: ignore
                    )
                ]),
                cp.StageProps(stage_name="build", actions=[
                    cpa.CodeBuildAction(
                        action_name="humus", 
                        input=source, 
                        project=project,  # type: ignore
                        role=role,  # type: ignore
                    ) 
                ]),
            ]
        )
