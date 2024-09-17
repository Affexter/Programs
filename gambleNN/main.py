import random
import torch
import torch.optim as optim
from torch import nn

class settings():
    def __init__(self):
        self.choices = 4

settings = settings()
multiples = [2, 4, 6, 8]
weights = (0.8, 0.6, 0.4, 0.2)

def winResult(output):
    winnum = random.randint(1, settings.choices)
    if output == winnum:
        return 1
    else: return 0

ticket = ticket()

class NeuralNetwork(nn.Module):
    def __init__(self):
        super(NeuralNetwork, self).__init__()
        self.layer1 = nn.Linear(1, 4)
        self.layer2 = nn.ReLU()
        self.layer3 = nn.Linear(4, 8)
        self.layer4 = nn.Sigmoid()
        self.layer5 = nn.Linear(8, 1)
    def forward(self, input):
        