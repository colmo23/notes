# generative ai

3Blue1Brown youtube

_GTP_
- Generative - makes something
- Pretrained - models have been pretrained on data
- Transformer - uses attention mechanism to work



Input text is converted to tokens (pieces of text, like words)
Each token is associated with a vector (sequence of numbers) which encode its meaning.
If vectors are elements in a multidimensional space then words with similar meanings are close to each other in that space.
So sentence or doc is a sequence of vectors
This is passed through an Attention Block. This allows vectors to talk to each other and pass and update their values. Eg figuring out if the word "model" means AI model or fashion model would be done in this step. That meaning is stored in the vector.
The next step is to pass the vectors through a MultiLayer Perceptron Block. This step is similar to asking a long sequence of questions to the vector and updating it. Vectors do not communicated with each other in this step.
All this steps are achieved by matrix multiplication.
The steps then repeat multiple times. Attention -> Multilayer Perceptron -> Attention, etc....

The model takes the seed text, predicts the next word, then feeds the whole lot back in an predicts the next word and so on.

System prompt: eg "What follows is a conversation between a user and a helpful AI assistant"
User prompt: Write a story about a happy clown

General Machine learning:
Input -> Model (lots of tunable parameters) -> Output

GTP3 has 170 billion parameters -> 28,000 matrices

training algorithms use back propogation

Input data (eg text, images) is converted to 1-d, 2-d or multidension arrays. Multidimension array is called a tensor
The arrays is processed by the model to give an output array. The output is a probability distribution of the next word in the sequence.
Tunable parameters are similar to weights - they are stored as matrices as well. Lots of vector multiplication takes place.

Embedding matrix - has a column for each word in the dictionary. Each column is a sequence of numbers. In GTP3 each word has 12,000 numbers to represent it (coordinates)

example of library that has word embeddings
model = genism.downloader.load("glove-wiki-gigaword-50")
model("tower")

E(man) - embedding vector for the word man
E(man)-E(woman) is similar to E(king)-E(queen)

Matric dot product: multiple 2 vectors and then add all the result. Dot product is positive if vectors are in similar direction, zero if parallel, negative if oppostive.
So similar words have more positive dot product.

Context size - total amount of tokens the model can handle at the same time. Is 2048 in gtp3
 

"softmax" is the probability distribution?

Wu - unembedding matrix

Probability distribution - sequence of numbers that represent probability that add up to 1.
Softmax is a algorithm to take a sequence of numbers and convert them so that the add up to 1so they can be used as a probability distribution
Temperature is a setting to affect the chance of using less probable values. T=0 implies always choose the highest probable value. 


A word in a sentance is given a vector. The same word will alway be given the same vector initially. Then the attentenion block modifies the vector depending on the words around it, ie the context of the word in the sentance. 
So the attention block refines the meaning of the word.

Also the vector for the last word in a block of text (aka context window) needs eventually to encode all of the meaning of the previous words in the text so that the model can accurately predict the next word

Query vector - it asks a questions of a word, eg are there any adjective in front of this noun?

Each word is transformed by a query vector and by a key vector(an answer to the query). The two vectors dot product produce a 2d matrix. Where a matrix entry is large it is said the word "attends" to the other word, eg provides some meaning to it

Attention(Q,K,V) = softmax(QK to power T)V / (sqaure root dk)
(dk is the dimension in the key space)

As the size of the context windows increases the size of the matrix increases exponentially 

The Attention stage is hugely parralizable meaning you can make use of GPUs

Andre Karpathy - lets build GTP from scratch
Chris Ola - 
VCublingX
Art of the problem


MLPs - mulit layer perceptrons - where facts are stored, eg names of people, etc

Transformer = Attention + MLP

Superposition - how facts are stored in martics
