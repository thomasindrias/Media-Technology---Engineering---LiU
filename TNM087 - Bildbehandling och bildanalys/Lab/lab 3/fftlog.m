function A = fftlog(f)
% Perfoms a log transformation of the spectrum.
% f = the image
% A = the log transformation

F = fftshift(fft2(f));
A = log(1 + abs(F));
A = A / max(A(:));

%figure, imshow(A);

end