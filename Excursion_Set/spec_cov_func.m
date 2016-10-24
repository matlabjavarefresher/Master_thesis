function c=spec_cov_func(d, A, alpha, omega, phi)

    c=A*exp(-alpha*d).*sin(omega*d+phi);
end