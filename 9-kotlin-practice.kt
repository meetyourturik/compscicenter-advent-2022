typealias Function = (Double) -> Double

fun interpolate(xs: List<Double>, ys: List<Double>): Function {
    require(xs.size == ys.size) { "Длина набора xs - ${xs.size}, а набора ys - ${ys.size}" }
    // return an anonymous function
    return { x ->
        // check interpolation region. Zero outside the region
        if (x < xs.first() || x > xs.last()) 0.0 else {
            // find section number
            val num: Int = xs.indexOfFirst { it > x }
            // num >=1
            if (num <= 0) {
                0.0
            } else {
                //return the result as last expression
                ys[num - 1] + (ys[num] - ys[num - 1]) / (xs[num] - xs[num - 1]) * (x - xs[num - 1])
            }
        }
    }
}

fun trap(xs: List<Double>, f: Function, g: Function) : Function {
    return { x ->
        var res = 0.0
        for (i in 1..(xs.size - 1)) {
            val from = xs[i - 1]
            val to = xs[i]
            res += (f(from) * g(x - from) + f(to) * g(x - to)) * (to - from) / 2.0
        }
        res
    }
}

fun conv(xs: List<Double>, ys1: List<Double>, ys2: List<Double>): List<Double> {
    println(ys1.joinToString(separator = " "))
    println(ys2.joinToString(separator = " "))
    require(xs.size == ys1.size && xs.size == ys2.size) {"все наборы одиниковы"}
    val f : Function = interpolate(xs, ys1)
    val g : Function = interpolate(xs, ys2)

    val con: Function = trap(xs, f, g)
    return xs.map{ con(it) }
}

fun main() {
    val n = 3 //readLine()!!.trim().toInt()
    val x: List<Double> = readLine()!!.split(" ").map { it.toDouble() }
    val y: List<Double> = readLine()!!.split(" ").map { it.toDouble() }

    var res: List<Double> = y
    for (i in 1..n-1) {
        res = conv(x, y, res)
    }
    println(res.joinToString(separator = " "))
}