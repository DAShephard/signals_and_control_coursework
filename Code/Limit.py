import sympy as sym
from sympy import exp

# z = exp(-0.0063s)
z, a, kc, tau_d, tau_i = sym.symbols('z, a, kc, tau_d, tau_i', real=True)
s = sym.symbols('s')

tf_pid = kc * (1 + tau_d*s + 1/( tau_i*s ))
tf_sys = (1.151*s + 0.1463) / (s**3 + 0.735*s**2 + 1.05*s)
tf_acc = 1 / (0.014*s + 1)
tf_sen = z / (0.0021*s + 1)

tf_cl = tf_sys * tf_pid * tf_acc / (1 + tf_sys * tf_pid * tf_acc * tf_sen)

# z = exp(-0.0063s)
lim = print(sym.limit(tf_cl, s, 0))
# As s -> 0, z -> 1
# lim = 1/z = 1/1 = 1