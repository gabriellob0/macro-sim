using CairoMakie


# Model
function sim_capital_motion(a = 0.5,d = 0.8, s = 0.5, K0 = 0.1, T = 20)
    Y = zeros(T+1)
    K = zeros(T+1)

    K[1] = K0
    Y[1] = K[1]^a

    for t in 1:T
        K[t+1] = (1 - d) * K[t] + s*Y[t]
        Y[t+1] = K[t]^a
    end

    return Y
end

Y = sim_capital_motion()

lines(1:21, Y)