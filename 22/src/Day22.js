import React, { Component } from "react";

const input = `
.#...#.#.##..##....##.#.#
###.###..##...##.##....##
....#.###..#...#####..#.#
.##.######..###.##..#...#
#..#..#..##..###...#..###
..####...#.##.#.#.##.####
#......#..####..###..###.
#####.##.#.#.##.###.#.#.#
.#.###....###....##....##
.......########.#.#...#..
...###.####.##..###.##..#
#.#.###.####.###.###.###.
.######...###.....#......
....##.###..#.#.###...##.
#.###..###.#.#.##.#.##.##
#.#.#..###...###.###.....
##..##.##...##.##..##.#.#
.....##......##..#.##...#
..##.#.###.#...#####.#.##
....##..#.#.#.#..###.#..#
###..##.##....##.#....##.
#..####...####.#.##..#.##
####.###...####..##.#.#.#
#.#.#.###.....###.##.###.
.#...##.#.##..###.#.###..
`
    .split("\n")
    .filter(row => row.length > 0);

const GridRow = ({ row, x, y, ry }) =>
    row.map((cell, i) => (
        <div
            style={{
                background:
                    y === ry && x === i
                        ? "red"
                        : cell === "#" ? "black" : "white",
                width: "5px",
                height: "5px",
                display: "inline-block"
            }}
            key={i}
        >
            &nbsp;
        </div>
    ));

const Grid = ({ grid, x, y }) =>
    grid.map((row, i) => (
        <div key={i} style={{ display: "flex", justifyContent: "center" }}>
            <GridRow row={row} x={x} y={y} ry={i} />
        </div>
    ));

const Width = 180,
    offset = 23;

class Day22 extends Component {
    state = {
        grid: new Array(Width).fill(".").map((_, i) => {
            let row =
                i > Math.floor(Width / 2 - input.length / 2 - offset)
                    ? input[
                          i - Math.floor(Width / 2 - input.length / 2 - offset)
                      ]
                    : null;

            let a = new Array(Width).fill(".");
            if (row) {
                a.splice(
                    Width / 2 - row.length / 2 + offset,
                    row.length,
                    ...row
                );
            }
            return a;
        }),
        x: Math.floor(Width / 2) + offset,
        y: Math.floor(Width / 2) - offset,
        vx: 0,
        vy: -1,
        bursts: 0,
        infected: 0
    };

    componentDidMount() {
        this.burstActivity();
    }

    burstActivity() {
        const { x, y, bursts, grid } = this.state;
        let { vx, vy, infected } = this.state;

        if (grid[y][x] === "#") {
            grid[y][x] = ".";

            [vx, vy] = this.turnLeft(vx, vy);
        } else {
            grid[y][x] = "#";
            infected += 1;

            [vx, vy] = this.turnRight(vx, vy);
        }

        if (Math.abs(vx) > 1 || Math.abs(vy) > 1) {
            console.log("JUMP", vx, vy);
        }

        this.setState({
            x: x + vx,
            y: y + vy,
            vx,
            vy,
            grid,
            infected,
            bursts: bursts + 1
        });
        if (bursts + 1 < 10000) {
            requestAnimationFrame(() => this.burstActivity());
        }
    }

    turnLeft(vx, vy) {
        let _vx = -1 * vy;
        vy = vx;
        return [_vx, vy];
    }

    turnRight(vx, vy) {
        let _vx = vy;
        vy = -1 * vx;
        return [_vx, vy];
    }

    render() {
        const { grid, width, bursts, x, y, infected } = this.state;

        return (
            <div>
                <h3 style={{ display: "flex", justifyContent: "center" }}>
                    bursts: {bursts}, pos: ({x}, {y}), infected: {infected}
                </h3>
                <div style={{ border: "1px solid red" }}>
                    <Grid grid={grid} x={x} y={y} />
                </div>
            </div>
        );
    }
}

export default Day22;
