/* ============================================ */
/* IA - 2º Trabalho - Raciocínio Probabilistico */
/* ============================================ */


/* Declarando as variáveis da tabela */
{light_is_on} = true | false.                    % Li  -> light_is_on
{street_condition} = dry | wet | snow_covered.   % Str -> street_condition
{flywheel_worn_out} = true | false.              % Flw -> flywheel_worn_out
{dynamo_slipping} = true | false.                % R   -> dynamo_slipping
{voltage} = true | false.                        % V   -> voltage
{light_bulb_ok} = true | false.                  % B   -> light_bulb_ok
{cable_ok} = true | false.                       % K   -> cable_ok



/* Definindo as variáveis independentes */
independent(street_condition).                  % Str
independent(flywheel_worn_out).                 % Flw
independent(light_bulb_ok).                     % B
independent(cable_ok).                          % K

independent(dynamo_slipping, light_bulb_ok).    % (R, B)
independent(dynamo_slipping, cable_ok).         % (R, K)
independent(voltage, light_bulb_ok).            % (V, B)
independent(voltage, cable_ok).                 % (V, K)



/* Probabilidades para as variáveis independentes */
p(street_condition(dry)) = 0.9.
p(street_condition(wet)) = 0.09.
p(street_condition(snow_covered)) = 0.01.

p(flywheel_worn_out(true)) = 0.4.
p(flywheel_worn_out(false)) = 0.6.

p(light_bulb_ok(true)) = 0.99.
p(light_bulb_ok(false)) = 0.01.

p(cable_ok(true)) = 0.9.
p(cable_ok(false)) = 0.1.



/* Regras gerais */
p(light_is_on(true)) :- voltage(true).          % Li é true se V é true (independente de R ser true)
p(voltage(true)) :- dynamo_slipping(true).      % V é true se R é true (independente de Str ou Flw ser true)

p(light_is_on(true)) = 0.99  :- voltage(true), light_bulb_ok(true), cable_ok(true).
p(light_is_on(true)) = 0.01  :- voltage(true), light_bulb_ok(true), cable_ok(false).
p(light_is_on(true)) = 0.01  :- voltage(true), light_bulb_ok(false), cable_ok(true).
p(light_is_on(true)) = 0.001 :- voltage(true), light_bulb_ok(false), cable_ok(false).
p(light_is_on(true)) = 0.3   :- voltage(false), light_bulb_ok(true), cable_ok(true).
p(light_is_on(true)) = 0.005 :- voltage(false), light_bulb_ok(true), cable_ok(false).
p(light_is_on(true)) = 0.005 :- voltage(false), light_bulb_ok(false), cable_ok(true).
p(light_is_on(true)) = 0     :- voltage(false), light_bulb_ok(false), cable_ok(false).

p(dynamo_slipping(true)) = 0.05 :- street_condition(dry), flywheel_worn_out(true).
p(dynamo_slipping(true)) = 0    :- street_condition(dry), flywheel_worn_out(false).
p(dynamo_slipping(true)) = 0.6  :- street_condition(wet), flywheel_worn_out(true).
p(dynamo_slipping(true)) = 0.05 :- street_condition(wet), flywheel_worn_out(false).
p(dynamo_slipping(true)) = 0.95 :- street_condition(snow_covered), flywheel_worn_out(true).
p(dynamo_slipping(true)) = 0.7  :- street_condition(snow_covered), flywheel_worn_out(false).

p(voltage(true))  = 0.04 :- dynamo_slipping(true).
p(voltage(false)) = 0.96 :- dynamo_slipping(true).
p(voltage(true))  = 0.99 :- dynamo_slipping(false).
p(voltage(false)) = 0.01 :- dynamo_slipping(false).



/* Query para o cálculo de P (V | Str = snow_covered) */
query(p(voltage(V) | street_condition(snow_covered))).
