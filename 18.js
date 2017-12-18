function initRegisters() {
    const registers = new Map(
        "abcdefghijklmnopqrstuvwxyz".split("").map(l => [l, 0])
    );
    registers.set("sound", null);
    registers.set("pointer", 0);

    return registers;
}

input = `
set i 31
set a 1
mul p 17
jgz p p
mul a 2
add i -1
jgz i -2
add a -1
set i 127
set p 464
mul p 8505
mod p a
mul p 129749
add p 12345
mod p a
set b p
mod b 10000
snd b
add i -1
jgz i -9
jgz a 3
rcv b
jgz b -1
set f 0
set i 126
rcv a
rcv b
set p a
mul p -1
add p b
jgz p 4
snd a
set a b
jgz 1 3
snd b
set f 1
add i -1
jgz i -11
snd a
jgz f -16
jgz a -19
`;

// test input
// input = `set a 1
// add a 2
// mul a a
// mod a 5
// snd a
// set a 0
// rcv a
// jgz a -1
// set a 1
// jgz a -2`;

function execute(registers, command) {
    const [com, val1, val2] = command.trim().split(" ");

    function getVal(val) {
        if (registers.has(val)) {
            return registers.get(val);
        } else {
            return Number(val);
        }
    }

    let jumped = false;

    const commands = {
        snd: a => registers.set("sound", getVal(a)),
        set: (a, b) => registers.set(a, getVal(b)),
        add: (a, b) => registers.set(a, getVal(a) + getVal(b)),
        mul: (a, b) => registers.set(a, getVal(a) * getVal(b)),
        mod: (a, b) => registers.set(a, getVal(a) % getVal(b)),
        rcv: a => (
            console.log("SOUND:", getVal("sound")),
            registers.set(a, getVal("sound"))
        ),
        jgz: (a, b) =>
            getVal(a) > 0
                ? ((jumped = true),
                  registers.set("pointer", getVal("pointer") + getVal(b)))
                : null
    };

    commands[com](val1, val2);

    if (!jumped) {
        registers.set("pointer", getVal("pointer") + 1);
    }

    return registers;
}

function star1() {
    let registers = initRegisters();
    const program = input.split("\n").filter(command => command.length > 0);

    // find sound value at first non-zero rcv
    while (
        registers.get("pointer") >= 0 &&
        registers.get("pointer") < program.length
    ) {
        registers = execute(registers, program[registers.get("pointer")]);
    }
}

star1();
