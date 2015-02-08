function A = gaussTransform(in, mu, Sigma)
R = chol(Sigma);
A = repmat(mu',length(in),1)+in*R;
end