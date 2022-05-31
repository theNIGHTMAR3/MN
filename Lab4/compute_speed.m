function speed_difference = compute_speed( time )

    g=9.81;
    v=750;
    m0=150000;
    q=2700;
    u=2000;
    speed=u*log(m0/(m0-q*time))-g*time;
    speed_difference=speed-v;

end