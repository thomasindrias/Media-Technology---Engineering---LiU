function theta = mkskatt(y, u)

N = length(y);

Rn = 0;
Fn = 0;

%[(y(n))^2, -y(n)*u(n); -y(n)*u(n), (u(n))^2];

for n=2:N
   Rn = [-y(n-1); u(n-1)] * [-y(n-1); u(n-1)]';
   Fn = [-y(n-1); u(n-1)] * y(n);
end

Rn = 1/N * Rn;
Fn = 1/N * Fn;

theta = inv(Rn) * Fn;

end