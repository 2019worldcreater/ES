function data_out = base_convert(data_in, base, new_base)
if new_base>base
data_in = data_in(1:...
floor(length(data_in)/(new_base/base))*(new_base/base));
end
for k=1:base
   binary_matrix(k,:) = floor(data_in/2^(base-k));%
   data_in = rem(data_in,2^(base-k));
end
newbase_matrix = reshape(binary_matrix, new_base, ...
size(binary_matrix,1)*size(binary_matrix,2)/new_base);
data_out = zeros(1, size(newbase_matrix,2));
for k=1:new_base
data_out = data_out + newbase_matrix(k,:)*(2^(new_base-k));%
end