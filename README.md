# Kaggle Whale Identification via Local-feature Based Image Retrieval

## Local Feature Extraction

We use the local feature with up-right orientation assumption as the whale image is upright (the sky on the top).
The [hesaff](https://github.com/perdoch/hesaff) is used for feature extraction.
To faciliate the batch extraction, the *batch_extract_whale_test.py* and *batch_extract_whale_train.py* in /code directory.

## Codebook Training


## Hamming Embedding Projection Learning


## Feature Quantization

## Inverted Index Building

## Initial Query

## Spatial Verification

## Display Local Feature Matches
For query 42, the first result by the baseline is illustrated as ![Initial Match](https://github.com/wangmaoCS/Kaggle_whale_identification/blob/master/query41.jpg), and the match result after spatial verification is ![SV Match](https://github.com/wangmaoCS/Kaggle_whale_identification/blob/master/query41_sp.jpg)