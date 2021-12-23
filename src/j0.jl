#     Bessel function of the first kind, order zero
#
# Returns Bessel function of the first kind, of order
# zero, of the argument.
#
# The domain is divided into the intervals [0, 5] and
# (5, infinity). In the first interval the following rational
# approximation is used:
#
# (w - r₁²)(w - r₂²) P₃(w) / Q₈(w)
# where w = x² and the two r's are zeros of the function
#
# In the second interval, the Hankel asymptotic expansion
# is employed with two rational functions of degree 6/6
# and 7/7.
#
# Cephes Math Library Release 2.8:  June, 2000
# Copyright 1984, 1987, 1989, 2000 by Stephen L. Moshier
# http://www.netlib.org/cephes/
#
#
function besselj0(x::Float64)
    if x <= 5.0
        z = x * x
        if x < 1.0e-5
            return 1.0 - z / 4.0
        end
        
        DR1 = 5.78318596294678452118E0
        DR2 = 3.04712623436620863991E1
        RP = (
            9.70862251047306323952E15, -2.49248344360967716204E14, 
            1.95617491946556577543E12, -4.79443220978201773821E9
            )
        RQ = (
            1.71086294081043136091E18, 3.18121955943204943306E16, 3.10518229857422583814E14, 
            2.11277520115489217587E12, 1.11855537045356834862E10, 4.84409658339962045305E7, 
            1.73785401676374683123E5, 4.99563147152651017219E2, 1.00000000000000000000E0
            )

        p = (z - DR1) * (z - DR2)
        p = p * evalpoly(z, RP) / evalpoly(z, RQ)
        return p
    else
        w = 5.0 / x
        q = 25.0 / (x * x)

        PP = (
            9.99999999999999997821E-1, 5.30324038235394892183E0, 8.74716500199817011941E0, 
            5.44725003058768775090E0, 1.23953371646414299388E0, 8.28352392107440799803E-2, 
            7.96936729297347051624E-4
            )
        PQ = (
            1.00000000000000000218E0, 5.30605288235394617618E0, 8.76190883237069594232E0, 
            5.47097740330417105182E0, 1.25352743901058953537E0, 8.56288474354474431428E-2, 
            9.24408810558863637013E-4
            )

        p = evalpoly(q, PP) / evalpoly(q, PQ)

        QP = (
            -6.05014350600728481186E0, -5.14105326766599330220E1, -1.47077505154951170175E2, 
            -1.77681167980488050595E2, -9.32060152123768231369E1, -1.95539544257735972385E1, 
            -1.28252718670509318512E0, -1.13663838898469149931E-2
            )
        QQ = (
            2.42005740240291393179E2, 2.06209331660327847417E3, 5.93072701187316984827E3, 
            7.24046774195652478189E3, 3.88240183605401609683E3, 8.56430025976980587198E2, 
            6.43178256118178023184E1, 1.00000000000000000000E0
            )

        q = evalpoly(q, QP) / evalpoly(q, QQ)
        xn = x - 0.78539816339744830962
        p = p * cos(xn) - w * q * sin(xn)
        return p * .79788456080286535588 / sqrt(x)
    end
end


function besselj0(x::Float32)
    if x < 0.0f0
        x *= -1
    end

    if x <= 2.0f0
        z = x * x
        if x < 1.0f-3
            return 1.0f0 - 0.25f0 * z
        end

        JP = (
            -1.729150680240724f-1, 1.332913422519003f-2, -3.969646342510940f-4,
            6.388945720783375f-6, -6.068350350393235f-8
        )

        DR1 = 5.78318596294678452118f0
        p = (z - DR1) * evalpoly(z, JP)
        return p
    else
        q = 1.0f0 / x
        w = sqrt(q)

        MO = (
            7.978845717621440f-1, -3.355424622293709f-6, -4.969382655296620f-2,
            -3.560281861530129f-3, 1.197549369473540f-1, -2.145007480346739f-1,
            1.864949361379502f-1, -6.838999669318810f-2
        )

        PH = (
            -1.249992184872738f-1,  6.490598792654666f-2, -1.939906941791308f-1,
            1.001973420681837f0, -4.974978466280903f0, 1.756221482109099f1,
            -3.630592630518434f1, 3.242077816988247f1,
        )

        p = w * evalpoly(q, MO)
        w = q * q
        xn = q * evalpoly(w, PH) - 0.78539816339744830962f0
        p = p * cos(xn + x)
        return p
    end
end




const J0_2N = (
    big"3.133239376997663645548490085151484674892E16", big"-5.479944965767990821079467311839107722107E14",
    big"6.290828903904724265980249871997551894090E12", big"-3.633750176832769659849028554429106299915E10", 
    big"1.207743757532429576399485415069244807022E8", big"-2.107485999925074577174305650549367415465E5",
    big"1.562826808020631846245296572935547005859E2"
)
const J0_2D = (
    big"2.005273201278504733151033654496928968261E18", big"2.063038558793221244373123294054149790864E16", 
    big"1.053350447931127971406896594022010524994E14",big"3.496556557558702583143527876385508882310E11", 
    big"8.249114511878616075860654484367133976306E8",big"1.402965782449571800199759247964242790589E6", 
    big"1.619910762853439600957801751815074787351E3", big"1.00000000000000000000000000000000000000000"
)
const P16_IN = (
    big"-1.901689868258117463979611259731176301065E-16", big"-1.798743043824071514483008340803573980931E-13",
    big"-6.481746687115262291873324132944647438959E-11", big"-1.150651553745409037257197798528294248012E-8",
    big"-1.088408467297401082271185599507222695995E-6", big"-5.551996725183495852661022587879817546508E-5",
    big"-1.477286941214245433866838787454880214736E-3", big"-1.882877976157714592017345347609200402472E-2",
    big"-9.620983176855405325086530374317855880515E-2", big"-1.271468546258855781530458854476627766233E-1"
)

const P16_ID = (
    big"2.704625590411544837659891569420764475007E-15", big"2.562526347676857624104306349421985403573E-12",
    big"9.259137589952741054108665570122085036246E-10", big"1.651044705794378365237454962653430805272E-7",
    big"1.573561544138733044977714063100859136660E-5", big"8.134482112334882274688298469629884804056E-4",
    big"2.219259239404080863919375103673593571689E-2", big"2.976990606226596289580242451096393862792E-1",
    big"1.713895630454693931742734911930937246254E0", big"3.231552290717904041465898249160757368855E0",
    big"1.000000000000000000000000000000000000000E0"
)

const Q16_IN = (
    big"2.343640834407975740545326632205999437469E-18", big"2.667978112927811452221176781536278257448E-15",
    big"1.178415018484555397390098879501969116536E-12", big"2.622049767502719728905924701288614016597E-10",
    big"3.196908059607618864801313380896308968673E-8", big"2.179466154171673958770030655199434798494E-6",
    big"8.139959091628545225221976413795645177291E-5", big"1.563900725721039825236927137885747138654E-3",
    big"1.355172364265825167113562519307194840307E-2", big"3.928058355906967977269780046844768588532E-2",
    big"1.107891967702173292405380993183694932208E-2",
)

const Q16_ID = (
    big"3.199850952578356211091219295199301766718E-17", big"3.652601488020654842194486058637953363918E-14",
    big"1.620179741394865258354608590461839031281E-11", big"3.629359209474609630056463248923684371426E-9",
    big"4.473680923894354600193264347733477363305E-7", big"3.106368086644715743265603656011050476736E-5",
    big"1.198239259946770604954664925153424252622E-3", big"2.446041004004283102372887804475767568272E-2",
    big"2.403235525011860603014707768815113698768E-1", big"9.491006790682158612266270665136910927149E-1",
    big"1.000000000000000000000000000000000000000E0"
) 

const P8_16N = (
    big"-2.335166846111159458466553806683579003632E-15", big"-1.382763674252402720401020004169367089975E-12",
    big"-3.192160804534716696058987967592784857907E-10", big"-3.744199606283752333686144670572632116899E-8",
    big"-2.439161236879511162078619292571922772224E-6", big"-9.068436986859420951664151060267045346549E-5",
    big"-1.905407090637058116299757292660002697359E-3", big"-2.164456143936718388053842376884252978872E-2",
    big"-1.212178415116411222341491717748696499966E-1", big"-2.782433626588541494473277445959593334494E-1",
    big"-1.670703190068873186016102289227646035035E-1"
)


const P8_16D = (
    big"3.321126181135871232648331450082662856743E-14", big"1.971894594837650840586859228510007703641E-11",
    big"4.571144364787008285981633719513897281690E-9", big"5.396419143536287457142904742849052402103E-7",
    big"3.551548222385845912370226756036899901549E-5", big"1.342353874566932014705609788054598013516E-3",
    big"2.899133293006771317589357444614157734385E-2", big"3.455374978185770197704507681491574261545E-1",
    big"2.116616964297512311314454834712634820514E0", big"5.850768316827915470087758636881584174432E0",
    big"5.655273858938766830855753983631132928968E0",
    big"1.000000000000000000000000000000000000000E0"
)

const P5_8N = (
    big"-1.270478335089770355749591358934012019596E-12", big"-4.007588712145412921057254992155810347245E-10",
    big"-4.815187822989597568124520080486652009281E-8", big"-2.867070063972764880024598300408284868021E-6",
    big"-9.218742195161302204046454768106063638006E-5", big"-1.635746821447052827526320629828043529997E-3",
    big"-1.570376886640308408247709616497261011707E-2", big"-7.656484795303305596941813361786219477807E-2",
    big"-1.659371030767513274944805479908858628053E-1", big"-1.185340550030955660015841796219919804915E-1",
    big"-8.920026499909994671248893388013790366712E-3",
)


const P5_8D = (
    big"1.806902521016705225778045904631543990314E-11", big"5.728502760243502431663549179135868966031E-9",
    big"6.938168504826004255287618819550667978450E-7", big"4.183769964807453250763325026573037785902E-5",
    big"1.372660678476925468014882230851637878587E-3", big"2.516452105242920335873286419212708961771E-2",
    big"2.550502712902647803796267951846557316182E-1", big"1.365861559418983216913629123778747617072E0",
    big"3.523825618308783966723472468855042541407E0", big"3.656365803506136165615111349150536282434E0",
    big"1.000000000000000000000000000000000000000E0"
)
const Q5_8N = (
    big"1.750399094021293722243426623211733898747E-13",
    big"6.483426211748008735242909236490115050294E-11",
    big"9.279430665656575457141747875716899958373E-9",
    big"6.696634968526907231258534757736576340266E-7",
    big"2.666560823798895649685231292142838188061E-5",
    big"6.025087697259436271271562769707550594540E-4",
    big"7.652807734168613251901945778921336353485E-3",
    big"5.226269002589406461622551452343519078905E-2",
    big"1.748390159751117658969324896330142895079E-1",
    big"2.378188719097006494782174902213083589660E-1",
    big"8.383984859679804095463699702165659216831E-2",
)
  

const Q5_8D = (
    big"2.389878229704327939008104855942987615715E-12",
    big"8.926142817142546018703814194987786425099E-10",
    big"1.294065862406745901206588525833274399038E-7",
    big"9.524139899457666250828752185212769682191E-6",
    big"3.908332488377770886091936221573123353489E-4",
    big"9.250427033957236609624199884089916836748E-3",
    big"1.263420066165922645975830877751588421451E-1",
    big"9.692527053860420229711317379861733180654E-1",
    big"3.937813834630430172221329298841520707954E0",
    big"7.603126427436356534498908111445191312181E0",
    big"5.670677653334105479259958485084550934305E0",
    big"1.000000000000000000000000000000000000000E0"
)


const P4_5N = (
    big"-9.791405771694098960254468859195175708252E-10", big"-1.917193059944531970421626610188102836352E-7",
    big"-1.393597539508855262243816152893982002084E-5", big"-4.881863490846771259880606911667479860077E-4",
    big"-8.946571245022470127331892085881699269853E-3", big"-8.707474232568097513415336886103899434251E-2",
    big"-4.362042697474650737898551272505525973766E-1", big"-1.032712171267523975431451359962375617386E0",
    big"-9.630502683169895107062182070514713702346E-1", big"-2.251804386252969656586810309252357233320E-1",
)


const P4_5D = (
    big"1.392555487577717669739688337895791213139E-8", big"2.748886559120659027172816051276451376854E-6",
    big"2.024717710644378047477189849678576659290E-4", big"7.244868609350416002930624752604670292469E-3",
    big"1.373631762292244371102989739300382152416E-1", big"1.412298581400224267910294815260613240668E0",
    big"7.742495637843445079276397723849017617210E0", big"2.138429269198406512028307045259503811861E1",
    big"2.651547684548423476506826951831712762610E1", big"1.167499382465291931571685222882909166935E1",
    big"1.000000000000000000000000000000000000000E0"
)
  

const P3r2_4N = (
    big"-2.589155123706348361249809342508270121788E-8", big"-3.746254369796115441118148490849195516593E-6",
    big"-1.985595497390808544622893738135529701062E-4", big"-5.008253705202932091290132760394976551426E-3",
    big"-6.529469780539591572179155511840853077232E-2", big"-4.468736064761814602927408833818990271514E-1",
    big"-1.556391252586395038089729428444444823380E0", big"-2.533135309840530224072920725976994981638E0",
    big"-1.605509621731068453869408718565392869560E0", big"-2.518966692256192789269859830255724429375E-1"
)

const Q8_16N = (
    big"1.001954266485599464105669390693597125904E-17",
    big"7.545499865295034556206475956620160007849E-15",
    big"2.267838684785673931024792538193202559922E-12",
    big"3.561909705814420373609574999542459912419E-10",
    big"3.216201422768092505214730633842924944671E-8",
    big"1.731194793857907454569364622452058554314E-6",
    big"5.576944613034537050396518509871004586039E-5",
    big"1.051787760316848982655967052985391418146E-3",
    big"1.102852974036687441600678598019883746959E-2",
    big"5.834647019292460494254225988766702933571E-2",
    big"1.290281921604364618912425380717127576529E-1",
    big"7.598886310387075708640370806458926458301E-2",
)
const Q8_16D = (
    big"1.368001558508338469503329967729951830843E-16",
    big"1.034454121857542147020549303317348297289E-13",
    big"3.128109209247090744354764050629381674436E-11",
    big"4.957795214328501986562102573522064468671E-9",
    big"4.537872468606711261992676606899273588899E-7",
    big"2.493639207101727713192687060517509774182E-5",
    big"8.294957278145328349785532236663051405805E-4",
    big"1.646471258966713577374948205279380115839E-2",
    big"1.878910092770966718491814497982191447073E-1",
    big"1.152641605706170353727903052525652504075E0",
    big"3.383550240669773485412333679367792932235E0",
    big"3.823875252882035706910024716609908473970E0",
    big"1.000000000000000000000000000000000000000E0"
)
const Q4_5N = (
    big"2.233870042925895644234072357400122854086E-11",
    big"5.146223225761993222808463878999151699792E-9",
    big"4.459114531468296461688753521109797474523E-7",
    big"1.891397692931537975547242165291668056276E-5",
    big"4.279519145911541776938964806470674565504E-4",
    big"5.275239415656560634702073291768904783989E-3",
    big"3.468698403240744801278238473898432608887E-2",
    big"1.138773146337708415188856882915457888274E-1",
    big"1.622717518946443013587108598334636458955E-1",
    big"7.249040006390586123760992346453034628227E-2",
    big"1.941595365256460232175236758506411486667E-3",
)

const Q4_5D = (
    big"3.049977232266999249626430127217988047453E-10",
    big"7.120883230531035857746096928889676144099E-8",
    big"6.301786064753734446784637919554359588859E-6",
    big"2.762010530095069598480766869426308077192E-4",
    big"6.572163250572867859316828886203406361251E-3",
    big"8.752566114841221958200215255461843397776E-2",
    big"6.487654992874805093499285311075289932664E-1",
    big"2.576550017826654579451615283022812801435E0",
    big"5.056392229924022835364779562707348096036E0",
    big"4.179770081068251464907531367859072157773E0",
    big"1.000000000000000000000000000000000000000E0"
)


const P3r2_4D = (
    big"3.682353957237979993646169732962573930237E-7",
    big"5.386741661883067824698973455566332102029E-5",
    big"2.906881154171822780345134853794241037053E-3",
    big"7.545832595801289519475806339863492074126E-2",
    big"1.029405357245594877344360389469584526654E0",
    big"7.565706120589873131187989560509757626725E0",
    big"2.951172890699569545357692207898667665796E1",
    big"5.785723537170311456298467310529815457536E1",
    big"5.095621464598267889126015412522773474467E1",
    big"1.602958484169953109437547474953308401442E1",
    big"1.000000000000000000000000000000000000000E0"
)


const P2r7_3r2N = (
    big"-1.917322340814391131073820537027234322550E-7",
    big"-1.966595744473227183846019639723259011906E-5",
    big"-7.177081163619679403212623526632690465290E-4",
    big"-1.206467373860974695661544653741899755695E-2",
    big"-1.008656452188539812154551482286328107316E-1",
    big"-4.216016116408810856620947307438823892707E-1",
    big"-8.378631013025721741744285026537009814161E-1",
    big"-6.973895635309960850033762745957946272579E-1",
    big"-1.797864718878320770670740413285763554812E-1",
    big"-4.098025357743657347681137871388402849581E-3"
)


const P2r7_3r2D = (
    big"2.726858489303036441686496086962545034018E-6",
    big"2.840430827557109238386808968234848081424E-4",
    big"1.063826772041781947891481054529454088832E-2",
    big"1.864775537138364773178044431045514405468E-1",
    big"1.665660052857205170440952607701728254211E0",
    big"7.723745889544331153080842168958348568395E0",
    big"1.810726427571829798856428548102077799835E1",
    big"1.986460672157794440666187503833545388527E1",
    big"8.645503204552282306364296517220055815488E0",
    big"1.000000000000000000000000000000000000000E0"
)

const P2r3_2r7N = (
    big"-1.594642785584856746358609622003310312622E-6",
    big"-1.323238196302221554194031733595194539794E-4",
    big"-3.856087818696874802689922536987100372345E-3",
    big"-5.113241710697777193011470733601522047399E-2",
    big"-3.334229537209911914449990372942022350558E-1",
    big"-1.075703518198127096179198549659283422832E0",
    big"-1.634174803414062725476343124267110981807E0",
    big"-1.030133247434119595616826842367268304880E0",
    big"-1.989811539080358501229347481000707289391E-1",
    big"-3.246859189246653459359775001466924610236E-3"
)

const P2r3_2r7D = (
    big"2.267936634217251403663034189684284173018E-5",
    big"1.918112982168673386858072491437971732237E-3",
    big"5.771704085468423159125856786653868219522E-2",
    big"8.056124451167969333717642810661498890507E-1",
    big"5.687897967531010276788680634413789328776E0",
    big"2.072596760717695491085444438270778394421E1",
    big"3.801722099819929988585197088613160496684E1",
    big"3.254620235902912339534998592085115836829E1",
    big"1.104847772130720331801884344645060675036E1",
    big"1.000000000000000000000000000000000000000E0"
)
    
const P2_2r3N = (
    big"-1.001042324337684297465071506097365389123E-4",
    big"-6.289034524673365824853547252689991418981E-3",
    big"-1.346527918018624234373664526930736205806E-1",
    big"-1.268808313614288355444506172560463315102E0",
    big"-5.654126123607146048354132115649177406163E0",
    big"-1.186649511267312652171775803270911971693E1",
    big"-1.094032424931998612551588246779200724257E1",
    big"-3.728792136814520055025256353193674625267E0",
    big"-3.000348318524471807839934764596331810608E-1",
)


const P2_2r3D = (
    big"1.423705538269770974803901422532055612980E-3",
    big"9.171476630091439978533535167485230575894E-2",
    big"2.049776318166637248868444600215942828537E0",
    big"2.068970329743769804547326701946144899583E1",
    big"1.025103500560831035592731539565060347709E2",
    big"2.528088049697570728252145557167066708284E2",
    big"2.992160327587558573740271294804830114205E2",
    big"1.540193761146551025832707739468679973036E2",
    big"2.779516701986912132637672140709452502650E1",
    big"1.000000000000000000000000000000000000000E0"
)

const Q2r7_3r2N = (
    big"7.584861620402450302063691901886141875454E-8",
    big"9.300939338814216296064659459966041794591E-6",
    big"4.112108906197521696032158235392604947895E-4",
    big"8.515168851578898791897038357239630654431E-3",
    big"8.971286321017307400142720556749573229058E-2",
    big"4.885856732902956303343015636331874194498E-1",
    big"1.334506268733103291656253500506406045846E0",
    big"1.681207956863028164179042145803851824654E0",
    big"8.165042692571721959157677701625853772271E-1",
    big"9.805848115375053300608712721986235900715E-2"
)
const Q2r7_3r2D = (
    big"1.035586492113036586458163971239438078160E-6",
    big"1.301999337731768381683593636500979713689E-4",
    big"5.993695702564527062553071126719088859654E-3",
    big"1.321184892887881883489141186815457808785E-1",
    big"1.528766555485015021144963194165165083312E0",
    big"9.561463309176490874525827051566494939295E0",
    big"3.203719484883967351729513662089163356911E1",
    big"5.497294687660930446641539152123568668447E1",
    big"4.391158169390578768508675452986948391118E1",
    big"1.347836630730048077907818943625789418378E1",
    big"1.000000000000000000000000000000000000000E0"
)

const Q3r2_4N = (
    big"6.126167301024815034423262653066023684411E-10",
    big"1.043969327113173261820028225053598975128E-7",
    big"6.592927270288697027757438170153763220190E-6",
    big"2.009103660938497963095652951912071336730E-4",
    big"3.220543385492643525985862356352195896964E-3",
    big"2.774405975730545157543417650436941650990E-2",
    big"1.258114008023826384487378016636555041129E-1",
    big"2.811724258266902502344701449984698323860E-1",
    big"2.691837665193548059322831687432415014067E-1",
    big"7.949087384900985370683770525312735605034E-2",
    big"1.229509543620976530030153018986910810747E-3",
)
const Q3r2_4D = (
    big"8.364260446128475461539941389210166156568E-9",
    big"1.451301850638956578622154585560759862764E-6",
    big"9.431830010924603664244578867057141839463E-5",
    big"3.004105101667433434196388593004526182741E-3",
    big"5.148157397848271739710011717102773780221E-2",
    big"4.901089301726939576055285374953887874895E-1",
    big"2.581760991981709901216967665934142240346E0",
    big"7.257105880775059281391729708630912791847E0",
    big"1.006014717326362868007913423810737369312E1",
    big"5.879416600465399514404064187445293212470E0",
    big"1.000000000000000000000000000000000000000E0"
)

const Q2r3_2r7N = (
    big"4.455027774980750211349941766420190722088E-7",
    big"4.031998274578520170631601850866780366466E-5",
    big"1.273987274325947007856695677491340636339E-3",
    big"1.818754543377448509897226554179659122873E-2",
    big"1.266748858326568264126353051352269875352E-1",
    big"4.327578594728723821137731555139472880414E-1",
    big"6.892532471436503074928194969154192615359E-1",
    big"4.490775818438716873422163588640262036506E-1",
    big"8.649615949297322440032000346117031581572E-2",
    big"7.261345286655345047417257611469066147561E-4",
)
const Q2r3_2r7D = (
    big"6.082600739680555266312417978064954793142E-6",
    big"5.693622538165494742945717226571441747567E-4",
    big"1.901625907009092204458328768129666975975E-2",
    big"2.958689532697857335456896889409923371570E-1",
    big"2.343124711045660081603809437993368799568E0",
    big"9.665894032187458293568704885528192804376E0",
    big"2.035273104990617136065743426322454881353E1",
    big"2.044102010478792896815088858740075165531E1",
    big"8.445937177863155827844146643468706599304E0",
    big"1.000000000000000000000000000000000000000E0"
)

const Q2_2r3N = (
    big"2.817566786579768804844367382809101929314E-6",
    big"2.122772176396691634147024348373539744935E-4",
    big"5.501378031780457828919593905395747517585E-3",
    big"6.355374424341762686099147452020466524659E-2",
    big"3.539652320122661637429658698954748337223E-1",
    big"9.571721066119617436343740541777014319695E-1",
    big"1.196258777828426399432550698612171955305E0",
  big"6.069388659458926158392384709893753793967E-1",
  big"9.026746127269713176512359976978248763621E-2",
  big"5.317668723070450235320878117210807236375E-4",
)

const Q2_2r3D = (
    big"3.846924354014260866793741072933159380158E-5",
    big"3.017562820057704325510067178327449946763E-3",
    big"8.356305620686867949798885808540444210935E-2",
    big"1.068314930499906838814019619594424586273E0",
    big"6.900279623894821067017966573640732685233E0",
    big"2.307667390886377924509090271780839563141E1",
    big"3.921043465412723970791036825401273528513E1",
    big"3.167569478939719383241775717095729233436E1",
    big"1.051023841699200920276198346301543665909E1",
    big"1.000000000000000000000000000000000000000E0"
)

const ONEOSQPI = big"5.6418958354775628694807945156077258584405E-1"

# DESCRIPTION:
#
# Returns Bessel function of first kind, order zero of the argument.
#
# The domain is divided into two major intervals [0, 2] and
# (2, infinity). In the first interval the rational approximation
# is J0(x) = 1 - x^2 / 4 + x^4 R(x^2)
# The second interval is further partitioned into eight equal segments
# of 1/x.
#
# J0(x) = sqrt(2/(pi x)) (P0(x) cos(X) - Q0(x) sin(X)),
# X = x - pi/4,
#
# and the auxiliary functions are given by
#
# J0(x)cos(X) + Y0(x)sin(X) = sqrt( 2/(pi x)) P0(x),
# P0(x) = 1 + 1/x^2 R(1/x^2)
#
# Y0(x)cos(X) - J0(x)sin(X) = sqrt( 2/(pi x)) Q0(x),
# Q0(x) = 1/x (-.125 + 1/x^2 R(1/x^2))
#
function besselj0(x::BigFloat)
    xx = abs(x)
    if iszero(xx)
        return one(BigFloat)
    elseif xx <= 2.0
        z = xx * xx
        p = z * z * evalpoly(z, J0_2N) / evalpoly(z, J0_2D)
        p -= 0.25 * z
        p += 1.0
        return p
    else
        xinv = 1.0 / xx
        z  = xinv * xinv
        if xinv <= 0.25
            if xinv <= 0.125
                if xinv <= 0.0625
                    p = evalpoly(z, P16_IN) / evalpoly(z, P16_ID)
                    q = evalpoly(z, Q16_IN) / evalpoly(z, Q16_ID)
                else
                    p = evalpoly(z, P8_16N) / evalpoly(z, P8_16D)
                    q = evalpoly(z, Q8_16N) /  evalpoly(z, Q8_16D)
                end
            elseif xinv <= 0.1875
                p = evalpoly(z, P5_8N) / evalpoly(z, P5_8D)
	            q = evalpoly(z, Q5_8N) / evalpoly(z, Q5_8D)
            else
                p = evalpoly(z, P4_5N) / evalpoly(z, P4_5D)
	            q = evalpoly(z, Q4_5N) / evalpoly(z, Q4_5D)
            end
        elseif xinv <= 0.5
            if xinv <= 0.375
                if xinv <= 0.3125
                    p = evalpoly(z, P3r2_4N) / evalpoly(z, P3r2_4D)
	                q = evalpoly(z, Q3r2_4N) / evalpoly(z, Q3r2_4D)
                else
                    p = evalpoly(z, P2r7_3r2N) / evalpoly(z, P2r7_3r2D)
                    q = evalpoly(z, Q2r7_3r2N) / evalpoly(z, Q2r7_3r2D)
                end
            elseif xinv <= 0.4375
                p = evalpoly(z, P2r3_2r7N) / evalpoly(z, P2r3_2r7D)
	            q = evalpoly(z, Q2r3_2r7N) / evalpoly(z, Q2r3_2r7D)
            else
                p = evalpoly(z, P2_2r3N) / evalpoly(z, P2_2r3D)
	            q = evalpoly(z, Q2_2r3N) / evalpoly(z, Q2_2r3D)
            end
        end
        
        p = 1.0 + z * p
        q = z * xinv * q
        q = q - 0.125 * xinv
        c = cos(xx)
        s = sin(xx)
        ss = s - c
        cc = s + c
        z = -cos(xx + xx)
        if (s * c) < 0
            cc = z / ss;
        else
            ss = z / cc;
        end
        z = ONEOSQPI * (p * cc - q * ss) / sqrt(xx)
        return z
    end
end
