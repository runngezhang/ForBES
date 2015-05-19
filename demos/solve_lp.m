function [x, y, fval, out] = solve_lp(c,A,b)
    [m,n] = size(A);
    K = [sparse(n, n), A', speye(n); A, sparse(m, m+n); c', -b', sparse(1, n)];
    d = [c; b; 0];
    prob.f1 = dist2_over_affine(sparse(2*n+m,1),K,d);
    prob.A1 = 1;
    prob.g = indFreePos([1:n,n+m+1:2*n+m]);
    prob.B = -1;
    prob.b = zeros(2*n+m,1);
    out = forbes(prob);
    x = out.x1(1:n);
    y = out.x1(n+1:n+m);
    fval = c'*x;
end