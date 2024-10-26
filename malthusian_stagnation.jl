using CairoMakie

motion_population(φ, N, X) = (φ/(1+φ))*√(N*X)
calculate_income_per_capita(X, N) = √(X/N)

function simulate_model(periods, initial_pop, X)
    N = zeros(periods)
    N[1] = initial_pop
    
    for t in 1:(periods-1)
        N[t+1] = motion_population(1.0, N[t], X)
    end
    
    y = calculate_income_per_capita.(X, N)
    
    return y, N
end

y_england, N_england = simulate_model(10, 2, 8)
y_ireland, N_ireland = simulate_model(10, 0.5, 4)

lines(1:10, N_england, label = "England")
lines!(1:10, N_ireland, label = "Ireland")
axislegend(position = :rb)
current_figure()

lines(1:10, y_england, label = "England")
lines!(1:10, y_ireland, label = "Ireland")
axislegend(position = :rb)
current_figure()