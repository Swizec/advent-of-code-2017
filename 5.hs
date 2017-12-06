
-- Jumps are relative: -1 moves to the previous instruction, and 2 skips the next one. Start at the first instruction in the list. The goal is to follow the jumps until one leads outside the list.

-- In addition, these instructions are a little strange; after each jump, the offset of that instruction increases by 1. So, if you come across an offset of 3, you would move three instructions forward, but change it to a 4 for the next time it is encountered.

input = [2,
        0,  
        0,
        1,
        2,
        0,
        1,
        -4,
        -5,
        0,
        -1,
        0,
        -6,
        0,
        -5,
        2,
        -9,
        -11,
        -15,
        -3,
        -11,
        -12,
        -14,
        -5,
        -16,
        -3,
        -13,
        -6,
        0,
        -3,
        -17,
        0,
        -17,
        -5,
        -1,
        -26,
        -21,
        -14,
        -20,
        -7,
        -24,
        -26,
        -32,
        -41,
        -2,
        -18,
        -18,
        -13,
        -28,
        0,
        -32,
        -3,
        -2,
        -14,
        -17,
        -54,
        -22,
        -34,
        -33,
        -34,
        0,
        -46,
        -3,
        -44,
        -58,
        -10,
        -56,
        -65,
        -46,
        -24,
        -20,
        -4,
        -27,
        -41,
        -33,
        -31,
        -20,
        -75,
        -73,
        -41,
        -36,
        -31,
        -70,
        -46,
        -1,
        -79,
        -61,
        -51,
        -77,
        -44,
        -55,
        -2,
        -18,
        -26,
        -50,
        -79,
        -59,
        -69,
        -62,
        -80,
        -13,
        -69,
        -97,
        -71,
        -24,
        -7,
        -40,
        -10,
        -23,
        -85,
        -97,
        -103,
        -55,
        -90,
        -40,
        -60,
        -98,
        -95,
        -39,
        -76,
        -63,
        -12,
        -2,
        -65,
        -109,
        -47,
        -12,
        -37,
        -5,
        -23,
        -125,
        -124,
        -49,
        -91,
        -70,
        -134,
        -54,
        -122,
        -135,
        -12,
        -23,
        -22,
        -83,
        -40,
        -133,
        -77,
        -88,
        -119,
        -146,
        -26,
        -12,
        -108,
        -63,
        -111,
        -148,
        -99,
        -77,
        -77,
        -76,
        -89,
        -37,
        -95,
        -105,
        -76,
        -137,
        -151,
        -146,
        -141,
        -162,
        -12,
        -68,
        -36,
        -116,
        -60,
        -73,
        -61,
        -60,
        -101,
        -168,
        -142,
        -143,
        -118,
        -165,
        -108,
        -179,
        -180,
        -11,
        -152,
        -67,
        -33,
        -10,
        -169,
        -155,
        -16,
        -136,
        -165,
        -164,
        2,
        1,
        -28,
        -131,
        -86,
        -153,
        -116,
        -113,
        -149,
        -66,
        -64,
        -36,
        -168,
        -116,
        -159,
        -15,
        -180,
        -125,
        -146,
        -135,
        -105,
        -161,
        -133,
        -207,
        -192,
        -192,
        -99,
        -146,
        -93,
        -21,
        -5,
        -189,
        -86,
        -16,
        -4,
        -44,
        -167,
        -20,
        -201,
        -110,
        -103,
        -223,
        -182,
        -71,
        -194,
        -68,
        -90,
        -237,
        -147,
        2,
        -88,
        -184,
        -90,
        -12,
        -119,
        -85,
        -138,
        -179,
        -152,
        -158,
        -82,
        -122,
        -179,
        -191,
        -120,
        -174,
        -165,
        -137,
        -181,
        -58,
        -250,
        -66,
        -194,
        -202,
        -171,
        -179,
        -137,
        -250,
        -248,
        -167,
        -108,
        -27,
        -175,
        -34,
        -254,
        -35,
        -157,
        -158,
        -31,
        -52,
        -236,
        -238,
        -247,
        -279,
        -209,
        -257,
        -167,
        -151,
        -7,
        -182,
        -2,
        -149,
        -87,
        -245,
        -141,
        -238,
        -186,
        -71,
        -97,
        -128,
        -147,
        -52,
        -93,
        -142,
        -197,
        -296,
        -73,
        -89,
        -14,
        -253,
        -190,
        -295,
        -312,
        -47,
        -236,
        -233,
        -238,
        -305,
        -121,
        -191,
        -251,
        -91,
        -307,
        -77,
        -228,
        -300,
        -197,
        -91,
        -191,
        -299,
        -77,
        -255,
        -51,
        -232,
        -64,
        -198,
        -187,
        -96,
        -86,
        -203,
        -216,
        -203,
        -343,
        -203,
        -78,
        -99,
        -174,
        -269,
        -349,
        -173,
        -52,
        -233,
        -154,
        -151,
        -304,
        -70,
        -235,
        -106,
        -226,
        -325,
        -142,
        -192,
        -115,
        -170,
        -15,
        -35,
        -174,
        -267,
        -108,
        -374,
        -128,
        -60,
        -131,
        -364,
        -371,
        -56,
        -96,
        -365,
        -305,
        -140,
        -50,
        -220,
        -179,
        -43,
        -356,
        -120,
        -216,
        -276,
        -103,
        -389,
        -28,
        -393,
        -341,
        -74,
        -85,
        -361,
        -68,
        -111,
        -4,
        -216,
        -263,
        -115,
        -194,
        -382,
        -285,
        -176,
        -145,
        -24,
        -59,
        -291,
        -170,
        -358,
        -226,
        -355,
        -292,
        -185,
        -297,
        -156,
        -248,
        -332,
        -319,
        -311,
        -46,
        -170,
        -428,
        -222,
        -35,
        -136,
        -206,
        -81,
        -330,
        -89,
        -75,
        -248,
        -42,
        -52,
        -24,
        -39,
        -129,
        -228,
        -242,
        -396,
        -222,
        -433,
        -168,
        -362,
        -4,
        -345,
        -395,
        -435,
        -14,
        -439,
        -136,
        -267,
        -417,
        -107,
        -177,
        -8,
        -208,
        -219,
        -222,
        -453,
        -155,
        -183,
        -252,
        0,
        -173,
        -71,
        -164,
        -187,
        -80,
        -292,
        -246,
        -89,
        -217,
        -227,
        -93,
        -244,
        -82,
        -51,
        -23,
        -283,
        -261,
        -50,
        -384,
        -415,
        -149,
        -103,
        -481,
        -404,
        -267,
        -80,
        -61,
        -130,
        -228,
        -310,
        -319,
        -186,
        -88,
        -173,
        -40,
        -69,
        -231,
        -398,
        -342,
        -176,
        -33,
        -304,
        -232,
        -220,
        -381,
        -436,
        -74,
        -116,
        -398,
        -467,
        -341,
        -483,
        -137,
        -5,
        -437,
        -67,
        -296,
        -137,
        -166,
        -216,
        -192,
        -307,
        -68,
        -319,
        -296,
        -524,
        -308,
        -68,
        -21,
        -515,
        -531,
        -221,
        -173,
        -261,
        -200,
        -450,
        -95,
        -366,
        -14,
        -29,
        -23,
        -173,
        -397,
        -373,
        -283,
        -104,
        -246,
        -153,
        -240,
        -378,
        -306,
        -495,
        -518,
        -459,
        -459,
        -340,
        -475,
        -96,
        -347,
        -8,
        -365,
        -7,
        -482,
        -113,
        -223,
        -313,
        -456,
        -89,
        -205,
        -507,
        -538,
        -115,
        -310,
        -484,
        -96,
        -367,
        -582,
        -32,
        -550,
        -247,
        -257,
        -479,
        -165,
        -346,
        -514,
        -188,
        -180,
        -506,
        -117,
        -92,
        -128,
        -507,
        -387,
        -52,
        -535,
        -210,
        -221,
        -560,
        -245,
        -70,
        -552,
        -99,
        -529,
        -607,
        -263,
        -345,
        -253,
        -426,
        -351,
        -92,
        -489,
        -478,
        -226,
        -606,
        -287,
        -277,
        -432,
        -336,
        -418,
        -94,
        -2,
        -192,
        -600,
        -454,
        -26,
        -3,
        -630,
        -294,
        -105,
        -439,
        -589,
        -425,
        -623,
        -451,
        -487,
        -117,
        -538,
        -78,
        -126,
        -485,
        -326,
        -455,
        -370,
        -389,
        -379,
        -158,
        -441,
        -524,
        -435,
        -160,
        -198,
        -172,
        -313,
        -380,
        -128,
        -166,
        -562,
        -427,
        -23,
        -616,
        -95,
        -188,
        -417,
        -419,
        -589,
        -488,
        -377,
        -520,
        -412,
        -348,
        -359,
        -488,
        -108,
        -409,
        -56,
        -460,
        -364,
        -233,
        -352,
        -59,
        -313,
        -609,
        -534,
        -432,
        -104,
        -514,
        -68,
        -83,
        -305,
        -308,
        -645,
        -535,
        -624,
        -453,
        -630,
        -274,
        -98,
        -280,
        -38,
        -443,
        -620,
        -411,
        -624,
        -379,
        -373,
        -338,
        -410,
        -382,
        -171,
        -645,
        -430,
        -294,
        -696,
        -513,
        -659,
        -690,
        -558,
        -2,
        -325,
        -234,
        -437,
        -610,
        -158,
        -186,
        -539,
        -405,
        -78,
        -100,
        -311,
        -201,
        -558,
        -604,
        -386,
        -457,
        -125,
        -419,
        -680,
        -147,
        -237,
        -107,
        -155,
        -550,
        -565,
        -214,
        -528,
        -353,
        -637,
        -6,
        -634,
        -332,
        -92,
        -474,
        -289,
        -617,
        -141,
        -398,
        -367,
        -537,
        -369,
        -88,
        -608,
        -699,
        -257,
        -602,
        -276,
        -406,
        -92,
        -746,
        -398,
        -387,
        -234,
        -331,
        -225,
        -480,
        -667,
        -264,
        -299,
        -673,
        -265,
        -142,
        -512,
        -573,
        -508,
        -551,
        -471,
        -270,
        -328,
        -648,
        -625,
        -779,
        -232,
        -393,
        -749,
        -84,
        -240,
        -59,
        -220,
        -55,
        -224,
        -350,
        -130,
        -23,
        -239,
        -105,
        -2,
        -762,
        -702,
        -163,
        -94,
        -350,
        -11,
        -176,
        -43,
        -654,
        -136,
        -348,
        -215,
        -67,
        -599,
        -757,
        -636,
        -367,
        -61,
        -209,
        -623,
        -342,
        -111,
        -93,
        -14,
        -613,
        -362,
        -837,
        -734,
        -468,
        -803,
        -548,
        -699,
        -744,
        -429,
        -243,
        -633,
        -382,
        -780,
        -668,
        -498,
        -664,
        -539,
        -781,
        -525,
        -697,
        -715,
        -126,
        -276,
        -504,
        -175,
        -592,
        -688,
        -92,
        -548,
        -298,
        -33,
        -532,
        -674,
        -57,
        -531,
        -488,
        -310,
        -90,
        -757,
        -496,
        -132,
        -733,
        -701,
        -61,
        -797,
        -215,
        -319,
        -700,
        -295,
        -572,
        -41,
        -140,
        -176,
        -479,
        -560,
        -164,
        -338,
        -794,
        -132,
        -453,
        -709,
        -445,
        -802,
        2,
        -336,
        -562,
        -802,
        -878,
        -547,
        -368,
        -502,
        -574,
        -275,
        -687,
        -560,
        -432,
        -423,
        -174,
        -367,
        -59,
        -605,
        -340,
        -626,
        -142,
        -601,
        -488,
        -299,
        -466,
        -521,
        -783,
        -140,
        -731,
        -779,
        -252,
        -663,
        -906,
        -410,
        -601,
        -524,
        -332,
        -750,
        -556,
        -730,
        -749,
        -294,
        -798,
        -93,
        -345,
        -316,
        -186,
        -634,
        -904,
        -237,
        -134,
        -765,
        -953,
        -170,
        -854,
        -910,
        -99,
        -782,
        -564,
        -505,
        -49,
        -827,
        -64,
        -297,
        -548,
        -841,
        -598,
        -414,
        -184,
        -67,
        -99,
        -880,
        -855,
        -722,
        -725,
        -582,
        -416,
        -473,
        -339,
        -491,
        -162,
        -311,
        -43,
        -938,
        -608,
        -524,
        -212,
        -4,
        -945,
        -544,
        -879,
        -382,
        -21,
        -512,
        -169,
        -284,
        -140,
        -588,
        -407,
        -56,
        -610,
        -75,
        -412,
        -321,
        -801,
        -881,
        -220,
        -388,
        -116,
        -962,
        -1007,
        -862,
        -20,
        -409,
        -116,
        -943,
        -558,
        -1001,
        -548,
        -302,
        -165,
        -730,
        -1012,
        -669,
        -875,
        -393,
        -979]


-- STAR 1
star1 :: [Int] -> Int -> Int -> Int
star1 jumps i n
    | i < 0 = n
    | i >= length jumps = n
    | otherwise = star1 (left ++ [jump+1] ++ tail) (i+jump) (n+1)
    where (left, right) = splitAt i jumps
          (jump:tail) = right

-- STAR 2
star2 :: [Int] -> Int -> Int -> Int
star2 jumps i n
    | i < 0 = n
    | i >= length jumps = n
    | jump < 3 = star2 (left ++ [jump+1] ++ tail) (i+jump) (n+1)
    | otherwise = star2 (left ++ [jump-1] ++ tail) (i+jump) (n+1)
    where (left, right) = splitAt i jumps
          (jump:tail) = right


main = print $ star2 input 0 0

--main = print $ splitAt 0 [0,3,0,1,-3]
--main = print $ tail [2]

-- bla = a ++ [k+1] ++ tail
--     where (a,b) = splitAt 2 [1,2,3,4]
--           (k:tail) = b

-- main = print $ bla