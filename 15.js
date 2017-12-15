function* star1generator(factor, startingValue, _) {
    let val = startingValue;
    while (true) {
        val = (val * factor) % 2147483647;
        yield val;
    }
}

function* star2generator(factor, startingValue, denominator) {
    let val = startingValue;
    while (true) {
        val = (val * factor) % 2147483647;
        if (val % denominator === 0) {
            yield val;
        }
    }
}

function countMatches({
    startA,
    startB,
    generator,
    denominators = [],
    sampleSize
}) {
    const A = generator(16807, startA, denominators[0]),
        B = generator(48271, startB, denominators[1]);

    let judge = 0,
        mask = 0b00000000000000001111111111111111;

    for (let i = 0; i < sampleSize; i++) {
        if ((A.next().value & mask) === (B.next().value & mask)) {
            judge += 1;
        }
    }

    return judge;
}

// console.log(countMatches({ startA: 591, startB: 393, generator: star1generator, sampleSize: 40000000 }));

console.log(
    countMatches({
        startA: 591,
        startB: 393,
        generator: star2generator,
        denominators: [4, 8],
        sampleSize: 5000000
    })
);
