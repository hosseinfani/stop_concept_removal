We evaluate the list of stopconcepts based on its impact on topic modeling. 
We chose LDA as the topic modeling method. 
We use MALLET (http://mallet.cs.umass.edu/) library for LDA which gives quality metrics on the output topics in an xml file, called diagnostics => http://mallet.cs.umass.edu/diagnostics.php

Sample evaluation results have been pushed for threshold-based (threshold subfolder) and topk% (topk subfolder) for stopconcept identification for 0.0 (i.e., empty list), 0.1, 0.2. We did up until 0.9, 1.0.
