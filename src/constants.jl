const YP_y0(::Type{Float64}) = (
    -1.84950800436986690637E16, 4.42733268572569800351E16, -3.46628303384729719441E15,
    8.75906394395366999549E13, -9.82136065717911466409E11, 5.43526477051876500413E9,
    -1.46639295903971606143E7, 1.55924367855235737965E4
)
const YQ_y0(::Type{Float64}) = (
    2.50596256172653059228E17, 3.17157752842975028269E15, 2.02979612750105546709E13,
    8.64002487103935000337E10, 2.68919633393814121987E8, 6.26107330137134956842E5,
    1.04128353664259848412E3, 1.00000000000000000000E0
)
const PP_y0(::Type{Float64}) = (
    9.99999999999999997821E-1, 5.30324038235394892183E0, 8.74716500199817011941E0,
    5.44725003058768775090E0, 1.23953371646414299388E0, 8.28352392107440799803E-2,
    7.96936729297347051624E-4
)
const PQ_y0(::Type{Float64}) = (
    1.00000000000000000218E0, 5.30605288235394617618E0, 8.76190883237069594232E0,
    5.47097740330417105182E0, 1.25352743901058953537E0, 8.56288474354474431428E-2,
    9.24408810558863637013E-4
)
const QP_y0(::Type{Float64}) = (
    -6.05014350600728481186E0, -5.14105326766599330220E1, -1.47077505154951170175E2,
    -1.77681167980488050595E2, -9.32060152123768231369E1, -1.95539544257735972385E1,
    -1.28252718670509318512E0, -1.13663838898469149931E-2
)
const QQ_y0(::Type{Float64}) = (
    2.42005740240291393179E2, 2.06209331660327847417E3, 5.93072701187316984827E3,
    7.24046774195652478189E3, 3.88240183605401609683E3, 8.56430025976980587198E2,
    6.43178256118178023184E1, 1.00000000000000000000E0
)
const YP_y1(::Type{Float64}) = (
    -7.78877196265950026825E17, 2.02439475713594898196E17,
    -8.12770255501325109621E15, 1.14509511541823727583E14,
    -6.47355876379160291031E11, 1.26320474790178026440E9
)
const YQ_y1(::Type{Float64}) = (
    3.97270608116560655612E18, 6.87141087355300489866E16,
    6.20557727146953693363E14, 3.88231277496238566008E12,
    1.87601316108706159478E10, 7.34811944459721705660E7,
    2.35564092943068577943E5, 5.94301592346128195359E2,
    1.00000000000000000000E0
)
const besseli0_small_coefs(::Type{Float32}) = (
    1.0000000416172086f0, 0.2499995567758189f0, 0.027778554423089f0,
    0.0017355879591086688f0, 6.96204574858338f-5, 1.8959194799355527f-6,
    4.298760429567388f-8, 3.8884953805853935f-10, 1.483799986601676f-11
)
const besseli0_small_coefs(::Type{Float64}) = (
    0.9999999999999998, 0.2500000000000052, 0.027777777777755364,
    0.001736111111149161, 6.94444444107536e-5, 1.9290123635366806e-6,
    3.9367592765038015e-8, 6.151201574092085e-10, 7.593827956729909e-12,
    7.596677643342155e-14, 6.255282299620455e-16, 4.470993793303175e-18,
    2.1859737023077178e-20, 2.0941557335286373e-22    
)
const besseli0_med_coefs(::Type{Float32}) = (
    0.3989423094522082f0, 0.049857687814784155f0, 0.028606362029333827f0,
    0.018926572151825607f0, 0.11423960556773063f0
)
const besseli0_med_coefs(::Type{Float64}) = (
    0.3989422804014326, 0.04986778505064754, 0.028050628512954097,
    0.02921968830978531, 0.04466889626137549, 0.10220642174207666,
    -0.9937439085650689, 91.25330271974727, -4901.408890977662,
    199209.2752981982, -6.181516298413396e6, 1.4830278710991925e8,
    -2.7695254643719645e9, 4.0351394830842026e10, -4.5768930327229974e11,
    4.0134844243070063e12, -2.6862476523182016e13, 1.3437999451218112e14,
    -4.856333741437621e14, 1.1962791200680235e15, -1.796269414464399e15,
    1.239942074380968e15
)
const besseli0_large_coefs(::Type{Float32}) =  (
   0.398942288181429f0, 0.04986085645388595f0, 0.028961207830173957f0
)
const besseli0_large_coefs(::Type{Float64}) = (
    0.3989422804014327, 0.04986778505003549, 0.028050629664438713,
    0.029218603406797997, 0.045199090067282434
)
const besseli1_small_coefs(::Type{Float32}) = (
    0.08333336088599108f0, 0.0069442679189687774f0, 0.00034740666242346436f0,
    1.1502079282185252f-5, 2.8884784673820464f-7, 3.686308746029452f-9,
    1.2271327751884605f-10
)
const besseli1_med_coefs(::Type{Float32}) = (
    3.98942115977513013f-1, -1.49581264836620262f-1, -4.76475741878486795f-2,
    -2.65157315524784407f-2, -1.47148600683672014f-1
)
const besseli1_small_coefs(::Type{Float64}) = (
    0.08333333333333334, 0.006944444444444374, 0.00034722222222248526,
    1.1574074073690356e-5, 2.7557319253050506e-7, 4.920949730519126e-9,
    6.834656365321179e-11, 7.593985414952446e-13, 6.904652315442046e-15,
    5.2213850252454655e-17, 3.405120412140281e-19, 1.6398527256182257e-21,
    1.3161876924566675e-23
)
const besseli1_med_coefs(::Type{Float64}) = (
    0.39894228040143276, -0.149603355151029, -0.04675104787903509,
    -0.04090746353279043, -0.05744911840910781,-0.12283724006390319,
    1.0023632527650936, -94.90954045770921, 5084.06899084327,
    -206253.5613716743, 6.387439538535799e6, -1.529244018923123e8,
    2.849523551208316e9, -4.141884344471782e10, 4.6860149658304974e11,
    -4.097852944580042e12, 2.7345051110005453e13, -1.3634833112030364e14,
    4.909983186948892e14, -1.2048200837913132e15, 1.8014682382937435e15,
    -1.2377987428989558e15
)
const besseli1_large_coefs(::Type{Float64}) = (
    0.39894228040143265, -0.14960335515036183, -0.0467510491854453,
    -0.04090618769936314, -0.05808395099511361
)
const besseli1_large_coefs(::Type{Float32}) = (
    0.3989422695655856f0, -0.1495936968314777f0, -0.04802187089304704f0
)
const JP_j0(::Type{Float32}) = (
    -1.729150680240724f-1, 1.332913422519003f-2, -3.969646342510940f-4,
    6.388945720783375f-6, -6.068350350393235f-8
)
const MO_j0(::Type{Float32}) = (
    7.978845717621440f-1, -3.355424622293709f-6, -4.969382655296620f-2,
    -3.560281861530129f-3, 1.197549369473540f-1, -2.145007480346739f-1,
    1.864949361379502f-1, -6.838999669318810f-2
)
const PH_j0(::Type{Float32}) = (
    -1.249992184872738f-1,  6.490598792654666f-2, -1.939906941791308f-1,
    1.001973420681837f0, -4.974978466280903f0, 1.756221482109099f1,
    -3.630592630518434f1, 3.242077816988247f1,
)
const JP32 = (
    -3.405537384615824f-2, 1.937383947804541f-3, -4.541343896997497f-5,
    6.009061827883699f-7, -4.878788132172128f-9
)
const YP32 = (
    4.202369946500099f-2, -2.641785726447862f-3, 6.719543806674249f-5,
    -9.496460629917016f-7, 8.061978323326852f-9
)
const MO132 = (
    7.978845453073848f-1, 4.976029650847191f-6, 1.493389585089498f-1,
    5.435364690523026f-3, -2.102302420403875f-1, 3.138238455499697f-1,
    -2.284801500053359f-1,6.913942741265801f-2,
)
const PH132 = (
    3.749989509080821f-1, -1.637986776941202f-1, 3.503787691653334f-1,
    -1.544842782180211f0, 7.222973196770240f0, -2.485774108720340f1,
    5.073465654089319f1, -4.497014141919556f1,
)
const YP_y1(::Type{Float32}) = (
    1.707584643733568f-1, -1.584289289821316f-2, 5.344486707214273f-4,
    -9.413212653797057f-6, 9.454583683980369f-8
)
const MO_y1(::Type{Float32}) = (
    7.978845717621440f-1, -3.355424622293709f-6, -4.969382655296620f-2,
    -3.560281861530129f-3, 1.197549369473540f-1, -2.145007480346739f-1,
    1.864949361379502f-1, -6.838999669318810f-2
)
const PH_y1(::Type{Float32}) = (
    -1.249992184872738f-1,  6.490598792654666f-2, -1.939906941791308f-1,
    1.001973420681837f0, -4.974978466280903f0, 1.756221482109099f1,
    -3.630592630518434f1, 3.242077816988247f1,
)
const P1_k0(::Type{Float32}) = (
    -1.372508979104259711f-1, 2.622545986273687617f-1, 5.047103728247919836f-3
)
const Q1_k0(::Type{Float32}) = (
    1.000000000000000000f0, -8.928694018000029415f-2, 2.985980684180969241f-3
)
const P2_k0(::Type{Float32}) = (
    1.159315158f-1, 2.789828686f-1, 2.524902861f-2,
    8.457241514f-4, 1.530051997f-5
)
const P3_k0(::Type{Float32}) = (
    2.533141220f-1, 5.221502603f-1,
    6.380180669f-2, -5.934976547f-2
)
const Q3_k0(::Type{Float32}) = (
    1.000000000f0, 2.679722431f0,
    1.561635813f0, 1.573660661f-1
)
const P1_k0(::Type{Float64}) = (
    -1.372509002685546267e-1, 2.574916117833312855e-1,
    1.395474602146869316e-2, 5.445476986653926759e-4,
    7.125159422136622118e-6
)
const Q1_k0(::Type{Float64}) = (
    1.000000000000000000e+00, -5.458333438017788530e-02,
    1.291052816975251298e-03, -1.367653946978586591e-05
)
const P2_k0(::Type{Float64}) = (
    1.159315156584124484e-01, 2.789828789146031732e-01,
    2.524892993216121934e-02, 8.460350907213637784e-04,
    1.491471924309617534e-05, 1.627106892422088488e-07,
    1.208266102392756055e-09, 6.611686391749704310e-12
)
const P3_k0(::Type{Float64}) = (
    2.533141373155002416e-1, 3.628342133984595192e0,
    1.868441889406606057e1, 4.306243981063412784e1,
    4.424116209627428189e1, 1.562095339356220468e1,
    -1.810138978229410898e0, -1.414237994269995877e0,
    -9.369168119754924625e-2
)
const Q3_k0(::Type{Float64}) = (
    1.000000000000000000e0, 1.494194694879908328e1,
    8.265296455388554217e1, 2.162779506621866970e2,
    2.845145155184222157e2, 1.851714491916334995e2,
    5.486540717439723515e1, 6.118075837628957015e0,
    1.586261269326235053e-1
)
const Y_k0 = 1.137250900268554688


const Y_k1(::Type{Float32}) = 8.695471287f-2
const Y_k1(::Type{Float64}) = 8.69547128677368164e-2

const Y2_k1(::Type{Float32}) = 1.450342178f0
const Y2_k1(::Type{Float64}) = 1.45034217834472656

const P1_k1(::Type{Float32}) = (
    -3.621379531f-3, 7.131781976f-03, -1.535278300f-5
)
const P1_k1(::Type{Float64}) = (
    -3.62137953440350228e-3, 7.11842087490330300e-3,
    1.00302560256614306e-5, 1.77231085381040811e-6
)
const Q1_k1(::Type{Float32}) = (
    1.000000000f0, -5.173102701f-2, 9.203530671f-4
)
const Q1_k1(::Type{Float64}) = (
    1.00000000000000000e0, -4.80414794429043831e-2,
    9.85972641934416525e-4, -8.91196859397070326e-6
)
const P2_k1(::Type{Float32}) = (
    -3.079657469f-1, -8.537108913f-2,
    -4.640275408f-3, -1.156442414f-4
)
const P2_k1(::Type{Float64}) = (
    -3.07965757829206184e-1, -7.80929703673074907e-02,
    -2.70619343754051620e-3, -2.49549522229072008e-5
)
const Q2_k1(::Type{Float32}) = (
    one(Float32), zero(Float32)
)
const Q2_k1(::Type{Float64}) = (
    1.00000000000000000e0, -2.36316836412163098e-2,
    2.64524577525962719e-4, -1.49749618004162787e-6
)

const P3_k1(::Type{Float32}) = (
    -1.970280088f-1, 2.188747807f-2,
    7.270394756f-1, 2.490678196f-1
)
const P3_k1(::Type{Float64}) = (
    -1.97028041029226295e-1, -2.32408961548087617e0,
    -7.98269784507699938e0, -2.39968410774221632e0,
    3.28314043780858713e1, 5.67713761158496058e1,
    3.30907788466509823e1, 6.62582288933739787e0,
    3.08851840645286691e-1
)
const Q3_k1(::Type{Float32}) = (
    1.000000000f0, 2.274292882f0,
    9.904984851f-1, 4.585534549f-2
)
const Q3_k1(::Type{Float64}) = (
    1.00000000000000000e0, 1.41811409298826118e1,
    7.35979466317556420e1, 1.77821793937080859e2,
    2.11014501598705982e2, 1.19425262951064454e2,
    2.88448064302447607e1, 2.27912927104139732e0,
    2.50358186953478678e-2
)
