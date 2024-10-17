using CairoMakie


# Production function
produce(cap, tech, pop, cap_elas = 0.3) = cap^cap_elas * (tech*pop)^(1-cap_elas)

# Laws of motion
motion_capital(cap, inc, dep = 0.5, savings = 0.2) = (1-dep)*cap + savings*inc
motion_population(pop, growth_rate = 0) = (1+growth_rate)*pop
motion_technology(tech, growth_rate = 0.2) = (1+growth_rate)*tech 


# At the steady state, capital is (0.2 / (0.2 + 0.5))^(1 / (1 - 0.3)),
# which equals (2/7)^(1/0.7) ~= 0.167


# Model
function simulate_growth(periods = 10, initial_cap = 0.1, initial_pop = 1, initial_tech = 1)
    Y = zeros(periods)
    K = zeros(periods)
    N = zeros(periods)
    A = zeros(periods)
    
    K[1] = initial_cap
    N[1] = initial_pop
    A[1] = initial_tech
    
    for t in 1:periods
        Y[t] = produce(K[t], A[t], N[t])
        
        if t < periods
            K[t+1] = motion_capital(K[t], Y[t])
            N[t+1] = motion_population(N[t])
            A[t+1] = motion_technology(A[t])
        end
    end
    
    return Y, K
end

scot_cap = 0.167
eng_cap = 0.167 / 2

Y_england, K_england = simulate_growth(10, eng_cap, 1, 1)
Y_scotland, K_scotland = simulate_growth(10, scot_cap, 1, 1)

# Plot evolution of income
lines(1:10, Y_england, label = "England")
lines!(1:10, Y_scotland, label = "Scotland")
axislegend(position = :rb)
current_figure()

# Plot evolution of capital
lines(1:10, K_scotland)
