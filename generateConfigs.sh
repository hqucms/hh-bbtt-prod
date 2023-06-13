#! /bin/bash

# MC, 2018UL
cmsDriver.py mc_2018UL --mc --eventcontent NANOAODSIM --datatier NANOAODSIM --fileout file:nano.root --conditions 106X_upgrade2018_realistic_v16_L1v1 --step NANO --filein file:inMINIAOD.root --era Run2_2018,run2_nanoAOD_106Xv2 --no_exec -n -1

# Data, 2018UL
cmsDriver.py data_2018UL --data --eventcontent NANOAOD --datatier NANOAOD --fileout file:nano.root --conditions 106X_dataRun2_v36 --step NANO --filein file:inMINIAOD.root --era Run2_2018,run2_nanoAOD_106Xv2 --no_exec -n -1

# MC, 2017UL
cmsDriver.py mc_2017UL --mc --eventcontent NANOAODSIM --datatier NANOAODSIM --fileout file:nano.root --conditions 106X_mc2017_realistic_v10 --step NANO --filein file:inMINIAOD.root --era Run2_2017,run2_nanoAOD_106Xv2 --no_exec -n -1

# Data, 2017UL
cmsDriver.py data_2017UL --data --eventcontent NANOAOD --datatier NANOAOD --fileout file:nano.root --conditions 106X_dataRun2_v36 --step NANO --filein file:inMINIAOD.root --era Run2_2017,run2_nanoAOD_106Xv2 --no_exec -n -1

# MC, 2016ULpreVFP
cmsDriver.py mc_2016ULpreVFP --mc --eventcontent NANOAODSIM --datatier NANOAODSIM --fileout file:nano.root --conditions 106X_mcRun2_asymptotic_preVFP_v11 --step NANO --filein file:inMINIAOD.root --era Run2_2016_HIPM,run2_nanoAOD_106Xv2 --no_exec -n -1

# Data, 2016ULpreVFP
cmsDriver.py data_2016ULpreVFP --data --eventcontent NANOAOD --datatier NANOAOD --fileout file:nano.root --conditions 106X_dataRun2_v36 --step NANO --filein file:inMINIAOD.root --era Run2_2016_HIPM,run2_nanoAOD_106Xv2 --no_exec -n -1

# MC, 2016ULpostVFP
cmsDriver.py mc_2016ULpostVFP --mc --eventcontent NANOAODSIM --datatier NANOAODSIM --fileout file:nano.root --conditions 106X_mcRun2_asymptotic_v17 --step NANO --filein file:inMINIAOD.root --era Run2_2016,run2_nanoAOD_106Xv2 --no_exec -n -1

# Data, 2016ULpostVFP
cmsDriver.py data_2016ULpostVFP --data --eventcontent NANOAOD --datatier NANOAOD --fileout file:nano.root --conditions 106X_dataRun2_v36 --step NANO --filein file:inMINIAOD.root --era Run2_2016,run2_nanoAOD_106Xv2 --no_exec -n -1

for cfg in $(ls *UL*.py); do
    echo "Adding ParticleNet raw scores to ${cfg}"
    sed -i -e 's@# Customisation from command line@# Customisation from command line\nfrom RecoBTag.ONNXRuntime.pfParticleNetFromMiniAODAK8_cff import _pfParticleNetFromMiniAODAK8JetTagsProbs\nfrom PhysicsTools.NanoAOD.common_cff import Var\nfor prob in _pfParticleNetFromMiniAODAK8JetTagsProbs:\n    name = "ParticleNet_raw_" + prob.split(":")[1]\n    setattr(process.fatJetTable.variables, name, Var("bDiscriminator('"'"'%s'"'"')" % prob, float, doc=prob, precision=-1))@' ${cfg}
done
