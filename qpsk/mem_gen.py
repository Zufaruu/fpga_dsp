import math

# Here is the parameter of the wave function
n_sample = 1000
n_bits = 16
phase_init = math.radians(270) 

f = open("G:/Xilinx_2022/Vivado/2022.1/proyek/qpsk/qpsk.srcs/sources_1/new/270.mem","w+") # for overwriting
# f = open("G:/Xilinx_2022/Vivado/2022.1/proyek/qpsk/qpsk.srcs/sources_1/new/sine270.mem","w")  # for creating new one

amplitude = 2**n_bits - 1
sample_value_init = int(amplitude / 2)
sample_value = sample_value_init
sample_freq = 0

for i in range(0, n_sample):
    sample_freq = int((amplitude / 2) * math.sin((2 * math.pi * i / n_sample) + phase_init))

    if sample_value_init + sample_freq < amplitude:
        sample_value = sample_value_init + sample_freq
    else:
        sample_value = amplitude
    
    hexed_sample_value = hex(sample_value)
    match len(hexed_sample_value) :
        case 3:
            hexed_sample_value = hexed_sample_value[:2] + '000' + hexed_sample_value[2:]
            print(hexed_sample_value)
        case 4:
            hexed_sample_value = hexed_sample_value[:2] + '00' + hexed_sample_value[2:]
            print(hexed_sample_value)
        case 5:
            hexed_sample_value = hexed_sample_value[:2] + '0' + hexed_sample_value[2:]
            print(hexed_sample_value)
        case _:
            print(hexed_sample_value)

    if i == n_sample - 1:
        f.write(hexed_sample_value)
    else:
        f.write(hexed_sample_value + "\n")

f.close()
