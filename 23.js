function initRegisters() {
    const registers = new Map(
        "abcdefghijklmnopqrstuvwxyz".split("").map(l => [l, 0])
    );
    registers.set("sound", null);
    registers.set("pointer", 0);
    registers.set("mulcount", 0);

    return registers;
}

input = `
set b 79
set c b
jnz a 2
jnz 1 5
mul b 100 // 7900
sub b -100000 // 107900 = b
set c b // 107900
sub c -17000 // 124900 = c
set f 1 // 1 = f
set d 2 // 2 = d
set e 2 // 2 = e
set g d // 2 = g
mul g e // 4 = g
sub g b // -107896 = g
jnz g 2
set f 0
sub e -1 // 3 = e
set g e // 3 = g
sub g b // -107897 = g
jnz g -8 
sub d -1
set g d
sub g b
jnz g -13
jnz f 2
sub h -1
set g b
sub g c
jnz g 2
jnz 1 3
sub b -17
jnz 1 -23
`;

function execute(registers, command) {
    const [com, val1, val2] = command.trim().split(" ");

    function getVal(val) {
        if (registers.has(val)) {
            return registers.get(val);
        } else {
            return Number(val);
        }
    }

    let jumped = false,
        kill = false;

    const commands = {
        snd: a => registers.set("sound", getVal(a)),
        set: (a, b) => registers.set(a, getVal(b)),
        add: (a, b) => registers.set(a, getVal(a) + getVal(b)),
        sub: (a, b) => registers.set(a, getVal(a) - getVal(b)),
        mul: (a, b) => (
            registers.set("mulcount", getVal("mulcount") + 1),
            registers.set(a, getVal(a) * getVal(b))
        ),
        mod: (a, b) => registers.set(a, getVal(a) % getVal(b)),
        rcv: a => registers.set(a, getVal("sound")),
        jnz: (a, b) =>
            getVal(a) != 0
                ? ((jumped = true),
                  registers.set("pointer", getVal("pointer") + getVal(b)))
                : null
    };

    commands[com](val1, val2);

    if (!jumped) {
        registers.set("pointer", getVal("pointer") + 1);
    }

    return [kill, registers];
}

function star1() {
    let registers = initRegisters(),
        kill = false;
    const program = input.split("\n").filter(command => command.length > 0);

    // find sound value at first non-zero rcv
    while (
        registers.get("pointer") >= 0 &&
        registers.get("pointer") < program.length
    ) {
        console.log("loop");
        [kill, registers] = execute(
            registers,
            program[registers.get("pointer")]
        );
    }

    console.log(registers.get("mulcount"));
}

function star2() {
    let registers = initRegisters(),
        kill = false;
    const program = input
        .split("\n")
        .filter(command => command.length > 0)
        .map(command => command.split("//")[0]);
    registers.set("a", 1);

    // find sound value at first non-zero rcv
    while (
        registers.get("pointer") >= 0 &&
        registers.get("pointer") < program.length
    ) {
        [kill, registers] = execute(
            registers,
            program[registers.get("pointer")]
        );
        console.log("H", registers.get("pointer"));
    }

    console.log(registers.get("h"));
}

// borrowed from Reddit https://www.reddit.com/r/adventofcode/comments/7lms6p/2017_day_23_solutions/drnh5sx/
function solve2(n) {
    let r = {
        b: 79,
        c: 79,
        d: 0,
        f: 0,
        g: 0,
        h: 0
    };
    r["b"] = r["b"] * 100 + 100000;
    r["c"] = r["b"] + 17000;
    do {
        r["f"] = 1;
        r["d"] = 2;
        for (let d = r["d"]; d * d < r["b"]; ++d) {
            if (r["b"] % d === 0) {
                r["f"] = 0;
                break;
            }
        }
        if (r["f"] === 0) r["h"]++;
        r["g"] = r["b"] - r["c"];
        r["b"] += 17;
    } while (r["g"] !== 0);

    return r["h"];
}

//star1();
//star2();
console.log(solve2());
