import scipy.io as scio
import numpy as np
import time

from pydmd import FbDMD
from pydmd import CDMD
from pydmd import HankelDMD
from pydmd import HODMD

# load data
X_dict = scio.loadmat("data/fmri_table.mat")
X = X_dict['fmri_table']
p = 13
S1 = 50
cDMD_S50 = CDMD(svd_rank=S1, compression_matrix='uniform')
cDMD_S50.fit(X)
fbDMD_S50 = FbDMD(svd_rank=S1)
fbDMD_S50.fit(X)
hkDMD_S50 = HankelDMD(svd_rank=S1, d=p)
hkDMD_S50.fit(X)
hoDMD_S50 = HODMD(svd_rank=S1, d=p)
hoDMD_S50.fit(X)
DMD_dict = {}
DMD_dict['cDMD_S50'] = cDMD_S50.eigs
DMD_dict['fbdmd_S50'] = fbDMD_S50.eigs
DMD_dict['hkDMD_S50'] = hkDMD_S50.eigs
DMD_dict['hoDMD_S50'] = hoDMD_S50.eigs

S2 = 86
cDMD_S86 = CDMD(svd_rank=S2, compression_matrix='uniform')
cDMD_S86.fit(X)
fbDMD_S86 = FbDMD(svd_rank=S2)
fbDMD_S86.fit(X)
hkDMD_S86 = HankelDMD(svd_rank=S2, d=p)
hkDMD_S86.fit(X)
hoDMD_S86 = HODMD(svd_rank=S2, d=p)
hoDMD_S86.fit(X)
DMD_dict = {}
DMD_dict['cDMD_S86'] = cDMD_S86.eigs
DMD_dict['fbdmd_S86'] = fbDMD_S86.eigs
DMD_dict['hkDMD_S86'] = hkDMD_S86.eigs
DMD_dict['hoDMD_S86'] = hoDMD_S86.eigs
scio.savemat('data/DMD_dict.mat', DMD_dict)