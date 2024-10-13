import torch
import torch.nn as nn
import torch.optim as optim
import numpy as np

# Define the neural network architecture
class SorterNN(nn.Module):
    def __init__(self, input_size):
        super(SorterNN, self).__init__()
        self.fc1 = nn.Linear(input_size, 64)  # First layer
        self.fc2 = nn.Linear(64, 64)           # Second layer
        self.fc3 = nn.Linear(64, input_size)   # Output layer

    def forward(self, x):
        x = torch.relu(self.fc1(x))  # Activation function
        x = torch.relu(self.fc2(x))
        x = self.fc3(x)
        return x

# Function to generate random arrays and their sorted versions
def generate_data(num_samples, array_size):
    X = []
    y = []
    for _ in range(num_samples):
        array = np.random.rand(array_size) * 100  # Random float values
        sorted_array = np.sort(array)              # Sort the array
        X.append(array)
        y.append(sorted_array)
    return np.array(X, dtype=np.float32), np.array(y, dtype=np.float32)

# Hyperparameters
num_samples = 5000  # Number of training samples
array_size = 10     # Size of the arrays
num_epochs = 10000   # Number of training epochs
learning_rate = 0.001

# Generate training data
X_train, y_train = generate_data(num_samples, array_size)

# Convert data to PyTorch tensors
X_train_tensor = torch.from_numpy(X_train)
y_train_tensor = torch.from_numpy(y_train)

# Initialize the neural network, loss function, and optimizer
model = SorterNN(array_size)
criterion = nn.MSELoss()                 # Mean Squared Error Loss
optimizer = optim.Adam(model.parameters(), lr=learning_rate)

# Training loop
for epoch in range(num_epochs):
    model.train()
    optimizer.zero_grad()                  # Zero gradients

    # Forward pass
    outputs = model(X_train_tensor)        # Get predictions
    loss = criterion(outputs, y_train_tensor)  # Compute loss

    # Backward pass and optimization
    loss.backward()
    optimizer.step()

    if (epoch + 1) % 100 == 0:  # Print every 100 epochs
        print(f'Epoch [{epoch + 1}/{num_epochs}], Loss: {loss.item():.4f}')

# Testing the model
# Testing the model
model.eval()

# Replace this with your own list
# Example: test_array = [50, 10, 30, 20, 90, 40, 70, 60, 80]
test_array = input("Enter your list of numbers separated by spaces: ")
test_array = np.array([float(x) for x in test_array.split()])  # Convert input to a NumPy array

# Ensure the input array size matches the model's input size
if len(test_array) != array_size:
    print(f"Error: You need to provide exactly {array_size} numbers.")
else:
    test_tensor = torch.from_numpy(test_array.astype(np.float32))

    with torch.no_grad():
        predicted = model(test_tensor).numpy()
        print(f'Original array: {test_array}')
        print(f'Sorted by AI: {predicted}')
        print(f'True sorted array: {np.sort(test_array)}')
