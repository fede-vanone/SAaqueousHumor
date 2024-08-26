List of the files with explanantions

1) Set the parameters

Parameter_settings_EFAST

Sets all the parameters in the model, including those you want to span. 
pmean - is the mean value of the parameters
pmin - minimum value
pmax - maximum value

selectX - spans parameters with given frequesncies and saves them into the variable X and the file X.mat

it uses functions SETFREQ.m to set the frequencies and parameterdist.m to set distribution of the parameters (you can pick between uniform, normal or lognormal)

2) Run your solver for parameters from X.mat

- this is the file i1_2.m, which calls the function model_main.m 
The outpout is stored in variable Y. You can pick multiple outputs, like various concentrations, consumptions, etc

To make things quicker you can run in parallel for each parameter (variable i=1:k)

To run on the background I run the script run_i1 from the terminal

3) Analyse the results

Once you have your output Y, you can analyse it. I put analysis scripts in a different folder 'analysis'. Here hal_full.mat is my result and X.mat is the parameter file. 

To run SA, you can use figure_wat_graf.m file. It produces bar plots with sensitivity indices. These indices are calculated by function efast_sd_2.m 

I include a script that takes care of NANs if you have any: interp_nonan.m If you don't you can ignore it. 

Finally, to get scatter plots for each parameter you can run script some_plots.m
