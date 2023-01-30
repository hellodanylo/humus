from aws_cdk import App

from humus_build import HumusBuildStack

app = App()

humus_build = HumusBuildStack(app, 'HumusBuild')

app.synth()