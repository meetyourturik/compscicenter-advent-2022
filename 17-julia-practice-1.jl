struct Point
    x::Float64
    y::Float64
end

struct Projection
    p::Point
    rho::Float64
end

struct Segment
    start::Point
    fin::Point
    k::Float64
    b::Float64
end

function readPoint()
    strArr = split(readline(), ' ')
    return Point(parse(Float64, strArr[1]), parse(Float64, strArr[2]))
end
    
function distance(p1::Point, p2::Point)
    return sqrt((p1.x-p2.x)^2 + (p1.y-p2.y)^2)
end

# we only gonna compare points that are on the same line
Base.isless(x::Point, y::Point) = isless(x.x != y.x ? x.x : x.y, x.x != y.x ? y.x : y.y)
Base.isless(x::Projection, y::Projection) = isless(x.rho, y.rho)

# segments
n = parse(Int64, readline()) - 1
segments = []
pprev = readPoint()
for i = 1:n
    p = readPoint()
    if p.x == pprev.x # vertical
        k = NaN
        b = NaN
    elseif p.y == pprev.y # horizontal
        k = 0
        b = p.y
    else # normal
        k = (p.y - pprev.y) / (p.x - pprev.x)
        b = (pprev.y * p.x - p.y * pprev.x) / (p.x - pprev.x)
    end
    s = Segment(pprev, p, k, b)
    push!(segments,s)
    global pprev = p
end

# points
m = parse(Int64, readline())
for i = 1:m
    village = readPoint()
    projections = []
    for i = 1:n
        s = segments[i]
        if s.k == 0 # horizontal segment
            proj = Point(village.x, s.start.y)
        elseif isnan(s.k) # vertical segment
            proj = Point(s.start.x, village.y)
        else # normal segment
            k = -1/s.k
            b = village.y - k * village.x
            xp = (s.b - b) / (k - s.k)
            yp = k * xp + b
            proj = Point(xp, yp)
        end
        ss = min(s.start, s.fin)
        sf = max(s.start, s.fin)
        projp = max(min(proj, sf), ss)
        opproj = Projection(projp, distance(village, projp))
        push!(projections,opproj)
    end
    optimal = findmin(projections)[1]
    println(round(optimal.p.x, digits=3)," ",round(optimal.p.y, digits=3))
end
