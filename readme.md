<img src="https://raw.githubusercontent.com/allenai/allennlp/main/docs/img/allennlp-logo-dark.png" width="500" />

# Training models using declarative architectures with AllenNLP in Azure ML

This repository accompanies the post: [Declarative Machine Learning as a way to scale ML](https://santiagof.medium.com).


## Getting started

1. Install the Azure ML CLI v2. Follow the instruction at [Install and set up the CLI (v2)](https://docs.microsoft.com/en-us/azure/machine-learning/how-to-configure-cli) if it's the first time you use it.
2. Create the datasets

    ```bash
    az ml data create -f .aml/data/portuguese-hate-tweets.yml
    az ml data create -f .aml/data/portuguese-hate-tweets-eval.yml
    ```

    > Datasets are in `JSONL` format, given the `DatasetReader` was used in the model architecture. Those datasets will be registered as named datasets in Azure ML and injected into the training process using the `allennlp train` command.

3. Create a compute cluster where to train on:

    ```bash
    az ml compute create -f .aml/trainer-gpu.compute.yml
    ```

    > This compute cluster will have a minimum of 0 nodes, meaning that when no training jobs are running, it will scale down to 0 so you can reduce costs associated with it. This compute has GPUs.

4. Submit a training job

    ```bash
    az ml job create -f .aml/jobs/tweets-hate-classifier.job.yml
    ```

5. Once the run is completed, you can review the model and register it as a model in Azure ML:

    ![](docs/register-model.png)

## Contributing

This project welcomes contributions and suggestions. Open an issue and start the discussion! **Don't be shy!**