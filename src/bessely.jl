#    Bessel functions of the second kind of order zero and one
#                       bessely0, bessely1
#
#    Calculation of bessely0 is done in three branches using polynomial approximations
#
#    Branch 1: x <= 5.0
#              bessely0 = R(x^2) + 2*log(x)*besselj0(x) / pi
#    where r1 and r2 are zeros of J0
#    and P3 and Q8 are a 3 and 8 degree polynomial respectively
#    Polynomial coefficients are from [1] which is based on [2].
#    For tiny arugments the power series expansion is used.
#
#    Branch 2: 5.0 < x < 25.0
#              bessely0 = sqrt(2/(pi*x))*(sin(x - pi/4)*R7(x) - cos(x - pi/4)*R8(x))
#    Hankel's asymptotic expansion is used
#    where R7 and R8 are rational functions (Pn(x)/Qn(x)) of degree 7 and 8 respectively
#    See section 4 of [3] for more details and [1] for coefficients of polynomials
#
#   Branch 3: x >= 25.0
#              bessely0 = sqrt(2/(pi*x))*beta(x)*(sin(x - pi/4 - alpha(x))
#   See modified expansions given in [3]. Exact coefficients are used.
#
#   Calculation of bessely1 is done in a similar way as bessely0.
#   See [3] for details on similarities.
#
# [1] https://github.com/deepmind/torch-cephes
# [2] Cephes Math Library Release 2.8:  June, 2000 by Stephen L. Moshier
# [3] Harrison, John. "Fast and accurate Bessel function computation."
#     2009 19th IEEE Symposium on Computer Arithmetic. IEEE, 2009.
#

"""
    bessely0(x::T) where T <: Union{Float32, Float64}

Bessel function of the second kind of order zero, ``Y_0(x)``.
"""
function bessely0(x::T) where T <: Union{Float32, Float64}
    if x <= zero(x)
        if iszero(x)
            return T(-Inf)
        else
            return throw(DomainError(x, "NaN result for non-NaN input."))
        end
    elseif isinf(x)
        return zero(x)
    end
    return _bessely0_compute(x)
end
function _bessely0_compute(x::Float64)
    T = Float64
    if x <= 5.0
        z = x * x
        w = evalpoly(z, YP_y0(T)) / evalpoly(z, YQ_y0(T))
        w += TWOOPI(T) * log(x) * besselj0(x)
        return w
    elseif x < 25.0
        w = 5.0 / x
        z = w * w
        p = evalpoly(z, PP_y0(T)) / evalpoly(z, PQ_y0(T))
        q = evalpoly(z, QP_y0(T)) / evalpoly(z, QQ_y0(T))
        xn = x - PIO4(T)
        sc = sincos(xn)
        p = p * sc[1] + w * q * sc[2]
        return p * SQ2OPI(T) / sqrt(x)
    else
        xinv = inv(x)
        x2 = xinv*xinv
        if x < 120.0
            p1 = (one(T), -1/16, 53/512, -4447/8192, 3066403/524288, -896631415/8388608, 796754802993/268435456, -500528959023471/4294967296)
            q1 = (-1/8, 25/384, -1073/5120, 375733/229376, -55384775/2359296, 24713030909/46137344, -7780757249041/436207616)
            p = evalpoly(x2, p1)
            q = evalpoly(x2, q1)
        else
            p2 = (one(T), -1/16, 53/512, -4447/8192)
            q2 = (-1/8, 25/384, -1073/5120, 375733/229376)
            p = evalpoly(x2, p2)
            q = evalpoly(x2, q2)
        end

        a = SQ2OPI(T) * sqrt(xinv) * p
        xn = muladd(xinv, q, - PIO4(T))

        # the following computes b = sin(x + xn) more accurately
        # see src/misc.jl
        b = sin_sum(x, xn)
        return a * b
    end
end
function _bessely0_compute(x::Float32)
    T = Float32
    if x <= 2.0f0
        z = x * x
        YZ1 =  0.43221455686510834878f0
        w = (z - YZ1) * evalpoly(z, YP_y1(T))
        w += TWOOPI(T) * log(x) * besselj0(x)
        return w
    else
        q = 1.0f0 / x
        w = sqrt(q)
        p = w * evalpoly(q, MO_y1(T))
        w = q * q
        xn = q * evalpoly(w, PH_y1(T)) - PIO4(T)
        p = p * sin(xn + x)
        return p
    end
end

"""
    bessely1(x::T) where T <: Union{Float32, Float64}

Bessel function of the second kind of order one, ``Y_1(x)``.
"""
function bessely1(x::T) where T <: Union{Float32, Float64}
    if x <= zero(x)
        if iszero(x)
            return T(-Inf)
        else
            return throw(DomainError(x, "NaN result for non-NaN input."))
        end
    elseif isinf(x)
        return zero(x)
    end
    return _bessely1_compute(x)
end
function _bessely1_compute(x::Float64)
    T = Float64
    if x <= 5
        z = x * x
        w = x * (evalpoly(z, YP_y1(T)) / evalpoly(z, YQ_y1(T)))
        w += TWOOPI(T) * (besselj1(x) * log(x) - inv(x))
        return w
    elseif x < 25.0
        w = 5.0 / x
        z = w * w
        p = evalpoly(z, PP_j1(T)) / evalpoly(z, PQ_j1(T))
        q = evalpoly(z, QP_j1(T)) / evalpoly(z, QQ_j1(T))
        xn = x - THPIO4(T)
        sc = sincos(xn)
        p = p * sc[1] + w * q * sc[2]
        return p * SQ2OPI(T) / sqrt(x)
    else
        xinv = inv(x)
        x2 = xinv*xinv
        if x < 120.0
            p1 = (one(T), 3/16, -99/512, 6597/8192, -4057965/524288, 1113686901/8388608, -951148335159/268435456, 581513783771781/4294967296)
            q1 = (3/8, -21/128, 1899/5120, -543483/229376, 8027901/262144, -30413055339/46137344, 9228545313147/436207616)
            p = evalpoly(x2, p1)
            q = evalpoly(x2, q1)
        else
            p2 = (one(T), 3/16, -99/512, 6597/8192)
            q2 = (3/8, -21/128, 1899/5120, -543483/229376)
            p = evalpoly(x2, q2)
            q = evalpoly(x2, q2)
        end

        a = SQ2OPI(T) * sqrt(xinv) * p
        xn = muladd(xinv, q, - 3 * PIO4(T))

        # the following computes b = sin(x + xn) more accurately
        # see src/misc.jl
        b = sin_sum(x, xn)
        return a * b
    end
end
function _bessely1_compute(x::Float32)
    T = Float32
    if x <= 2.0f0
        z = x * x
        YO1 = 4.66539330185668857532f0
        w = (z - YO1) * x * evalpoly(z, YP32)
        w += TWOOPI(Float32) * (besselj1(x) * log(x) - inv(x))
        return w
    else
        q = inv(x)
        w = sqrt(q)
        p = w * evalpoly(q, MO132)
        w = q * q
        xn = q * evalpoly(w, PH132) - THPIO4(Float32)
        p = p * sin(xn + x)
        return p
    end
end