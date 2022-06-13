local baseline='neuralmind/bert-base-portuguese-cased';

{
    "dataset_reader": {
        "type": "text_classification_json",
        "tokenizer": {
            "type": "pretrained_transformer",
            "model_name": baseline,
        },
        "token_indexers": {
            "tokens": {
                "type": "pretrained_transformer",
                "model_name": baseline,
            }
        }
    },
    "data_loader": {
        "batch_sampler": {
            "type": "bucket",
            "batch_size" : 32
        }
    },
    "model": {
        "type": "basic_classifier",
        "vocab": {
            "type": "from_pretrained_transformer",
            "model_name": baseline,
        },
        "text_field_embedder": {
            "type": "basic",
            "token_embedders": {
                "tokens": {
                    "type": "pretrained_transformer",
                    "model_name": baseline
                }
            }
        },
        "seq2vec_encoder": {
            "type": "bert_pooler",
            "pretrained_model": baseline
        },
        "dropout": 0.1,
        "num_labels": 2,
    },
    "trainer": {
        "optimizer": {
            "type": "huggingface_adamw",
            "lr": 5e-5,
            "correct_bias": false,
            "weight_decay": 0.01,
            "parameter_groups": [
                [["bias", "LayerNorm.bias", "LayerNorm.weight", "layer_norm.weight"], {"weight_decay": 0.0}],
            ],
        },
        "learning_rate_scheduler": {
            "type": "slanted_triangular",
        },
        "checkpointer": {
            "keep_most_recent_by_count": 2,
        },
        "grad_norm": 1.0,
        "num_epochs": 15,
        "validation_metric": "+accuracy",
    },
    "train_data_path": 'data/portuguese-hate-speech-tweets/sample/data.json',
    "validation_data_path": 'data/portuguese-hate-speech-tweets-eval/sample/data.json',
}