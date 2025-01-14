function [C, sigma] = dataset3Params(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

C_set = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];
Sigma_set = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];
C_optimum = C_set(1);
Sigma_optimum = Sigma_set(1);

Err_iminus1= 1000;
for i=1:length(C_set)
    C_i = C_set(i);
    for j=1:length(Sigma_set)
        Sigma_i = Sigma_set(j);
        model = svmTrain(X, y, C_i, @(x1, x2) gaussianKernel(x1, x2, Sigma_i));
        predictions = svmPredict(model, Xval);
        err = mean(double(predictions ~= yval));
        if err < Err_iminus1
            C_optimum = C_i;
            Sigma_optimum = Sigma_i;
            Err_iminus1 = err;
        end;
    end;
end;

C = C_optimum;
sigma = Sigma_optimum;

% =========================================================================

end
