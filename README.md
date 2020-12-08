# Stopword Detection for Streaming Content
The removal of stopwords is an important preprocessing step in many natural language processing tasks, which can lead to enhanced performance and execution time. Many existing methods either rely on a predefined list of stopwords or compute word significance based on metrics such as tf-idf. The objective of our work in this paper is to identify stopwords, in an unsupervised way, for streaming textual corpora such as Twitter, which have a temporal nature. We propose to consider and model the dynamics of a word within the
streaming corpus to identify the ones that are less likely to be informative or discriminative. Our work is based on the `discrete wavelet transform (DWT)` of word signals in order to extract two features, namely `scale` and `energy`. We show that our proposed approach is effective in identifying stopwords and improves the quality of topics in the task of `topic detection`.

## Citation
```
@inproceedings{DBLP:conf/ecir/FaniBZBA18,
  author    = {Hossein Fani and
               Masoud Bashari and
               Fattane Zarrinkalam and
               Ebrahim Bagheri and
               Feras N. Al{-}Obeidat},
  title     = {Stopword Detection for Streaming Content},
  booktitle = {Advances in Information Retrieval - 40th European Conference on {IR} Research, {ECIR} 2018, Grenoble, France, March 26-29, 2018, Proceedings},
  series    = {Lecture Notes in Computer Science},
  volume    = {10772},
  pages     = {737--743},
  publisher = {Springer},
  year      = {2018},
  url       = {https://doi.org/10.1007/978-3-319-76941-7\_70},
  doi       = {10.1007/978-3-319-76941-7\_70}
}
```

## License
©2020. This work is licensed under a [CC BY-NC-SA 4.0](LICENSE.txt) license. 
