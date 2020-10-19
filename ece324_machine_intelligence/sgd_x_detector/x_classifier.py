import numpy as np
import pdb
import pandas as pd


class Xclassifier(object):
    def __init__(self, activation="relu", random_seed=1337):
        np.random.seed(random_seed)

        weights = np.random.normal(size=9)
        self.weights = weights

        self.bias = np.random.normal()
        assert activation in ["relu", "sigmoid", "linear"]
        self.activation = activation

    def sigmoid(self, inputs):
        return 1 / (1 + np.exp(-inputs))

    def forward_pass(self, inputs):
        # Input is of the dimension (n, 9) where n is the batch size
        assert inputs.shape[1] == 9, inputs.shape[1]
        assert len(inputs.shape) == 2

        inputs = np.dot(inputs, self.weights)
        output = inputs + self.bias

        if self.activation == "relu":
            output[output < 0] = 0

        elif self.activation == "sigmoid":
            output = self.sigmoid(output)

        return output

    def mse(self, output, labels):
        assert output.shape == labels.shape
        return np.square(labels - output)

    def compute_derivative(self, y, X):
        del_loss = y.flatten() - self.forward_pass(X)
        layer_compute = np.dot(X, self.weights)

        if self.activation == "linear":
            del_activation = layer_compute

        if self.activation == "relu":
            del_activation = np.copy(layer_compute)
            del_activation[del_activation < 0] = 0

        if self.activation == "sigmoid":
            del_activation = self.sigmoid(layer_compute) * (
                1 - self.sigmoid(layer_compute)
            )

        del_weight = X

        del_weight_tot = (
            del_weight * np.expand_dims(del_activation * del_loss, axis=0).T
        )
        del_bias = del_activation * del_loss

        assert del_weight_tot.shape == (y.shape[0], 9), (
            del_weight_tot.shape,
            y.flatten().shape,
        )
        assert del_bias.shape == y.flatten().shape

        return del_weight_tot.mean(axis=0), del_bias.mean()

    def update_weights(self, y, X, learning_rate=0.1):
        del_weights, del_bias = self.compute_derivative(y, X)
        self.bias = del_bias * learning_rate + self.bias
        self.weights = del_weights * learning_rate + self.weights


def main():
    
    df = pd.read_csv("./a2/traindata.csv")
    data = df.values

    df = pd.read_csv("./a2/trainlabel.csv")
    labels = df.values
    
    for activation in ['sigmoid', 'relu', 'linear']:
        classifier = Xclassifier(activation=activation)
        for i in range(100):
            print(i)
            classifier.update_weights(labels[0:10], data[0:10])

            print(classifier.forward_pass(data[0:10]))
            print(classifier.compute_derivative(labels[0:10], data[0:10]))

        print(labels[0:10])
        pdb.set_trace()


if __name__ == "__main__":
    main()
