%In this section I will run a series of low-rank approximations.
%Ak using reduced SVD for varying values of k.


k = 6;
Ak = U(:,1:k)*S(1:k,1:k)*V(:,1:k)';

%Rank: The number of linearly independent columns in a matrix is the rank
%of the matrix. The row and column rank of a matrix are always equal.

%Full rank: highest possible for a matrix of the same size.
%Rank deficient: if it does not have full rank.

%Please add the title name by youself.
figure,
imagesc(Ak);
colormap gray; 
axis image;
title('')


