function lambda_mean = compute_lambda(A, rho, sigma)

Na = 6.02214076E23;
lambda_mean = A / (Na * rho * sigma);

end