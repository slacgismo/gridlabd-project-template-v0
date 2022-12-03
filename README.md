# GridLAB-D Project Template

This GitHub repository template is designed to make setting up a GridLAB-D project repository on GitHub easy.

# Quick Start

## Step 1

Create a new repository using this repository as a template.

## Step 2

Edit the file `gridlabd.glm` to create your model.

## Step 3

Commit your new model to the `main` branch.

## Step 4

Click on the `Actions` tab to inspect the result of the latest simulation. 

## Step 5

Download the results from the latest action's artifact `gridlabd-results`.

# Advanced Topics

## Model files

For details on developing GridLAB-D model see https://docs.gridlabd.us.

## Pre-processing

You can create a pre-processing shell script named `gridlabd.pre`.

## Post-processing

You can create a post-processing shell script named `gridlabd.post`.

## Artifacts files

All the files in the repository are stored in the artifact download except `gridlabd.tar.gz`, `LICENSE`, and `README.md`.

# Pro-tips

## Using standard models

You can load a standard model by adding a `curl` command to the `gridlabd.pre` script. For example, to download the IEEE-13 model:

~~~
curl -sL https://models.gridlabd.us/gridlabd-4/IEEE/13.glm -o 13.glm
~~~

See https://github.com/slacgismo/gridlabd-models for details.

## Pre-load and post-load options

You can specify pre-load and post-load options by setting the `GLM_PRELOAD` and `GLM_POSTLOAD` options. Pre-load options are loaded before `gridlabd.glm` is loaded and post-load options are loaded after `gridlabd.glm`.

## Specifying the weather

You can load TMY3 weather using the `GLM_WEATHER` environment variable in the `gridlabd.pre` script. See https://github.com/slacgismo/gridlabd-weather for informaiton on available TMY3 weather files.

## Specifying the clock

You can specify the clock using the `GLM_TIMEZONE`, `GLM_STARTTIME`, and `GLM_STOPTIME` environment variables in the `gridlabd.pre` script.

## Using templates

You can use a template by setting the `GLM_TEMPLATE` environment variable in the `gridlabd.pre` script.  See https://github.com/slacgismo/gridlabd-template for information on available templates.
