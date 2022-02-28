#    Bessel functions of the first kind of order zero and one
#                       besselj0, besselj1
#
#    Calculation of besselj0 is done in three branches using polynomial approximations
#
#    Branch 1: x <= 5.0
#              besselj0 = (x^2 - r1^2)*(x^2 - r2^2)*P3(x^2) / Q8(x^2)
#    where r1 and r2 are zeros of J0
#    and P3 and Q8 are a 3 and 8 degree polynomial respectively
#    Polynomial coefficients are from [1] which is based on [2]
#    For tiny arugments the power series expansion is used.
#
#    Branch 2: 5.0 < x < 25.0
#              besselj0 = sqrt(2/(pi*x))*(cos(x - pi/4)*R7(x) - sin(x - pi/4)*R8(x))
#    Hankel's asymptotic expansion is used
#    where R7 and R8 are rational functions (Pn(x)/Qn(x)) of degree 7 and 8 respectively
#    See section 4 of [3] for more details and [1] for coefficients of polynomials
#
#   Branch 3: x >= 25.0
#              besselj0 = sqrt(2/(pi*x))*beta(x)*(cos(x - pi/4 - alpha(x))
#   See modified expansions given in [3]. Exact coefficients are used
#
#   Calculation of besselj1 is done in a similar way as besselj0.
#   See [3] for details on similarities.
#
# [1] https://github.com/deepmind/torch-cephes
# [2] Cephes Math Library Release 2.8:  June, 2000 by Stephen L. Moshier
# [3] Harrison, John. "Fast and accurate Bessel function computation."
#     2009 19th IEEE Symposium on Computer Arithmetic. IEEE, 2009.
#

#poly = Float64.(Tuple(ratfn_minimax(x->r(x,pts[i]), ((pts[i][1]-pts[i-1][1])/2, (pts[i][1]-pts[i+1][1])/2), 13, 0)[1]))

const PTS = (( 2.404825557695773 , -1.176691651530894e-16),
           ( 3.8317059702075125, -1.5269184090088067e-16),
           ( 5.520078110286311 ,  8.088597146146722e-17),
           ( 7.015586669815619 , -9.414165653410389e-17),
           ( 8.653727912911013 , -2.92812607320779e-16 ),
           (10.173468135062722 ,  4.482162274768888e-16),
           (11.791534439014281 ,  2.812956912778735e-16),
           (13.323691936314223 ,  2.600408064718813e-16),
           (14.930917708487787 , -7.070514505983074e-16),
           (16.470630050877634 , -1.619019544798128e-15),
           (18.071063967910924 , -9.658048089426209e-16),
           (19.615858510468243 , -1.004445634526616e-15),
           (21.21163662987926  ,  4.947077428784068e-16),
           (22.760084380592772 , -4.925749373614922e-16),
           (24.352471530749302 ,  9.169067133951066e-16))
const POLYS = ((0.0, -0.5191474972894669, 0.10793870175491979, 0.05660177443794914, -0.008657669593292222, -0.0021942003590739974, 0.0002643770365942964, 4.37291931443113e-5, -4.338825419759815e-6, -5.304927679598406e-7, 4.469819175606667e-8, 4.3284827345621115e-9, -3.135111000732148e-10, -2.628876489517534e-11),
               (-0.402759395702553, 2.476919088072758e-16, 0.20137969785127532, -0.017518715285670765, -0.013352611033152278, 0.0010359438492839443, 0.00037218755624680334, -2.4952042421113972e-5, -5.776086353844158e-6, 3.374317129436161e-7, 5.727482259215452e-8, -2.9561880489355444e-9, -3.905845672635605e-10, 1.971332566705736e-11),
               (0.0, 0.34026480655836816, -0.030820651425593214, -0.05298855286760721, 0.004631042145890388, 0.002257440229081131, -0.00017518572879518415, -4.6521091062878115e-5, 3.199785909661533e-6, 5.716500268232186e-7, -3.5112898510841466e-8, -4.684643389757727e-9, 2.562685034682206e-10, 2.7958958795750104e-11),
               (0.30011575252613254, -1.6640272822046001e-16, -0.15005787626306408, 0.007129737603121546, 0.011742619737383848, -0.0006260583453094324, -0.00035093119008693753, 1.7929701912295164e-5, 5.6239324892485754e-6, -2.668437501970219e-7, -5.6648488273749086e-8, 2.48117399780498e-9, 3.8876537586241154e-10, -1.6657136713437192e-11),
               (0.0, -0.27145229992838193, 0.015684124960953488, 0.044033774963413, -0.0025093022271948434, -0.0020603351551475315, 0.00011243486771159352, 4.482303558813413e-5, -2.288390108003442e-6, -5.679383588459768e-7, 2.693939234375692e-8, 4.737285529934781e-9, -2.0612709555352797e-10, -2.8163166483726606e-11),
               (-0.2497048770578432, 1.1807897766765572e-16, 0.12485243852891914, -0.0040907858517059345, -0.010102792347641438, 0.00038536375952213334, 0.00031859711440332953, -1.2373899600646271e-5, -5.3013932979548665e-6, 2.001098153528186e-7, 5.4711629662471434e-8, -1.9724572531751518e-9, -3.8121398193699247e-10, 1.3667679743782715e-11),
               (0.0, 0.23245983136472478, -0.009857064513825458, -0.03818600911162367, 0.0016073972920762946, 0.0018420433388794816, -7.581358465623415e-5, -4.159284549011371e-5, 1.650645590334915e-6, 5.425453494592871e-7, -2.0556207467977526e-8, -4.620018928884712e-9, 1.642028058414746e-10, 2.7701605444102412e-11),
               (0.21835940724787295, -8.89726402965429e-17, -0.10917970362393398, 0.0027314677279632535, 0.008944552393700088, -0.00026391472261453583, -0.00028847875053074687, 8.858193371737123e-6, 4.9233776180403375e-6, -1.5077786827161215e-7, -5.190218733666561e-8, 1.5539413886301204e-9, 3.674809363354973e-10, -1.1113645791216594e-11),
               (0.0, -0.20654643307799603, 0.006916736034268416, 0.034115572697347704, -0.001137276252948717, -0.0016680057255530109, 5.4841792064182565e-5, 3.837965853474541e-5, -1.2335804050962046e-6, -5.106259295634553e-7, 1.592333632709497e-8, 4.423517565793139e-9, -1.3138837384184105e-10, -2.6809397212536384e-11),
               (-0.19646537146865717, 6.979167865106427e-17, 0.09823268573432613, -0.001988037402152532, -0.008095530671166083, 0.00019440675128712672, 0.0002640383898036336, -6.666777683303928e-6, -4.5715696772304925e-6, 1.1666296153560847e-7, 4.8913639696764225e-8, -1.2379867207945651e-9, -3.508930968415813e-10, 9.07632091591013e-12),
               (0.0, 0.18772880304043943, -0.005194182350684612, -0.031096513233785917, 0.0008577442641273341, 0.0015312251534677639, -4.184307585284775e-5, -3.5603170534217916e-5, 9.58002109234601e-7, 4.795250964600283e-7, -1.263434500625308e-8, -4.20550167685701e-9, 1.065791122326672e-10, 2.5727417675684577e-11),
               (0.18006337534431555, -5.638484737644332e-17, -0.09003168767215539, 0.0015299132863046024, 0.0074441453680234426, -0.00015060569680378768, -0.0002443398416353605, 5.227001519013193e-6, 4.267152607972633e-6, -9.295966007495808e-8, -4.610438011417262e-8, 1.0049092632275165e-9, 3.339442682325105e-10, -7.4991079301099e-12),
               (0.0, -0.17326589422922986, 0.004084217951979124, 0.028749284970146657, -0.0006761643016121907, -0.0014215899173758441, 3.320978125391802e-5, 3.3264379323815026e-5, -7.684444100376941e-7, -4.515479818833484e-7, 1.0271599456634145e-8, 3.993903280527723e-9, -8.793975528824604e-11, -2.4610374225652004e-11),
               (-0.16718460047381803, 4.662597138876655e-17, 0.08359230023690671, -0.0012242529339116864, -0.006925682915280748, 0.00012100729852042988, 0.00022821854128498174, -4.230799709959437e-6, -4.007618360337058e-6, 7.601217108010105e-8, 4.358483157250522e-8, -8.317621452517008e-10, -3.178805429572483e-10, 6.284538399593043e-12),
               (0.0, 0.16170155068925002, -0.003320023400603752, -0.026859370386562005, 0.0005505380905962079, 0.001331699465921981, -2.7156832110124053e-5, -3.128954487528851e-5, 6.326902787990595e-7, 4.269717284901734e-7, -8.532904814909196e-9, -3.799560194537855e-9, 7.410932094856478e-11, 2.3903214947728713e-11))

"""
    besselj0(x::T) where T <: Union{Float32, Float64}

Bessel function of the first kind of order zero, ``J_0(x)``.
"""
function besselj0(x::Float64)
    T = Float64
    x = abs(x)
    isinf(x) && return zero(x)

    if x < 25.0
        x<pi/2 && return evalpoly(x*x, (1.0, -0.25, 0.01562499999999994, -0.00043402777777725544, 6.781684026082576e-6, -6.781683757550061e-8, 4.709479394601058e-10, -2.4016837144506874e-12, 9.104258208703104e-15))
        n = round(Int, fma(2/pi,x,-1/2))
        root = @inbounds PTS[n]
        r = x - root[1] - root[2]
        return evalpoly(r, @inbounds POLYS[n])
    else
        if x < 120.0
            p = (one(T), -1/16, 53/512, -4447/8192, 3066403/524288, -896631415/8388608, 796754802993/268435456, -500528959023471/4294967296)
            q = (-1/8, 25/384, -1073/5120, 375733/229376, -55384775/2359296, 24713030909/46137344, -7780757249041/436207616)
        else
            p = (one(T), -1/16, 53/512, -4447/8192)
            q = (-1/8, 25/384, -1073/5120, 375733/229376)
        end
        xinv = inv(x)
        x2 = xinv*xinv

        p = evalpoly(x2, p)
        a = SQ2OPI(T) * sqrt(xinv) * p
        xn = muladd(xinv, evalpoly(x2, q), - PIO4(T))

        # the following computes b = cos(x + xn) more accurately
        # see src/misc.jl
        b = cos_sum(x, xn)
        return a * b
    end
end
function besselj0(x::Float32)
    T = Float32
    x = abs(x)
    isinf(x) && return zero(x)

    if x <= 2.0f0
        z = x * x
        if x < 1.0f-3
            return 1.0f0 - 0.25f0 * z
        end
        DR1 = 5.78318596294678452118f0
        p = (z - DR1) * evalpoly(z, JP_j0(T))
        return p
    else
        q = inv(x)
        w = sqrt(q)
        p = w * evalpoly(q, MO_j0(T))
        w = q * q
        xn = q * evalpoly(w, PH_j0(T)) - PIO4(Float32)
        p = p * cos(xn + x)
        return p
    end
end

"""
    besselj1(x::T) where T <: Union{Float32, Float64}

Bessel function of the first kind of order one, ``J_1(x)``.
"""
function besselj1(x::Float64)
    T = Float64
    x = abs(x)
    isinf(x) && return zero(x)

    if x <= 5.0
        z = x * x
        w = evalpoly(z, RP_j1(T)) / evalpoly(z, RQ_j1(T))
        w = w * x * (z - 1.46819706421238932572e1) * (z - 4.92184563216946036703e1)
        return w
    elseif x < 25.0
        w = 5.0 / x
        z = w * w
        p = evalpoly(z, PP_j1(T)) / evalpoly(z, PQ_j1(T))
        q = evalpoly(z, QP_j1(T)) / evalpoly(z, QQ_j1(T))
        xn = x - THPIO4(T)
        sc = sincos(xn)
        p = p * sc[2] - w * q * sc[1]
        return p * SQ2OPI(T) / sqrt(x)
    else
        if x < 120.0
            p = (one(T), 3/16, -99/512, 6597/8192, -4057965/524288, 1113686901/8388608, -951148335159/268435456, 581513783771781/4294967296)
            q = (3/8, -21/128, 1899/5120, -543483/229376, 8027901/262144, -30413055339/46137344, 9228545313147/436207616)
        else
            p = (one(T), 3/16, -99/512, 6597/8192)
            q = (3/8, -21/128, 1899/5120, -543483/229376)
        end
        xinv = inv(x)
        x2 = xinv*xinv

        p = evalpoly(x2, p)
        a = SQ2OPI(T) * sqrt(xinv) * p
        xn = muladd(xinv, evalpoly(x2, q), - 3 * PIO4(T))

        # the following computes b = cos(x + xn) more accurately
        # see src/misc.jl
        b = cos_sum(x, xn)
        return a * b
    end
end
function besselj1(x::Float32)
    x = abs(x)
    isinf(x) && return zero(x)

    if x <= 2.0f0
        z = x * x
        Z1 = 1.46819706421238932572f1
        p = (z - Z1) * x * evalpoly(z, JP32)
        return p
    else
        q = inv(x)
        w = sqrt(q)
        p = w * evalpoly(q, MO132)
        w = q * q
        xn = q * evalpoly(w, PH132) - THPIO4(Float32)
        p = p * cos(xn + x)
        return p
    end
end
