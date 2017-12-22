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

const GridRow = ({ row }) =>
    row.map((cell, i) => (
        <div
            style={{
                background: cell === "#" ? "black" : "white",
                width: "5px",
                height: "5px",
                display: "inline-block"
            }}
            key={i}
        >
            &nbsp;
        </div>
    ));

const Grid = ({ grid }) =>
    grid.map((row, i) => (
        <div key={i} style={{ display: "flex", justifyContent: "center" }}>
            <GridRow row={row} />
        </div>
    ));

const Width = 80;

class Day22 extends Component {
    state = {
        grid: new Array(Width).fill(".").map((_, i) => {
            let row = i > Width / 2 ? input[i - Width / 2] : null;

            let a = new Array(Width).fill(".");
            if (row) {
                a.splice(Width / 2 - row.length / 2, row.lengt, ...row);
            }
            return a;
        }),
        x: Width / 2,
        y: Width / 2,
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

        this.setState({
            x: x + vx,
            y: y + vy,
            vx,
            vy,
            grid,
            infected,
            bursts: bursts + 1
        });
        if (bursts < 10000) {
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
                <Grid grid={grid} />
            </div>
        );
    }
}

export default Day22;
