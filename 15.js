function* generator(factor, startingValue) {
    let val = startingValue;
    while (true) {
        val = (val * factor) % 2147483647;
        yield val;
    }
}

function star1(startA, startB) {
    const A = generator(16807, startA),
        B = generator(48271, startB);

    let judge = 0,
        mask = 0b00000000000000001111111111111111;

    for (let i = 0; i < 40000000; i++) {
        if ((A.next().value & mask) === (B.next().value & mask)) {
            judge += 1;
        }
    }

    return judge;
}

console.log(star1(591, 393));
