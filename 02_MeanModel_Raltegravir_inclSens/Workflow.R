outputVenousBlood <- function(subFilter, dataDisplayName, pkParametersVenousBlood)
{
  return (Output$new(path = "Organism|PeripheralVenousBlood|Raltegravir|Plasma (Peripheral Venous Blood)", displayName = "Raltegravir", displayUnit = "µg/l", 
                     pkParameters = pkParametersVenousBlood,
                     dataFilter = paste0('OUTPUT=="Raltegravir_PLASMA" & ', subFilter),
                     dataDisplayName = dataDisplayName))
}

library("ospsuite.reportingengine")
Sys.setenv(LANG = "en")

workflowDir = getwd()
outputDir = file.path(workflowDir, "Report")

dataFile = file.path(workflowDir,'Data/Raltegravir_PK.txt')
dictionaryFile = file.path(workflowDir,'Data/tpDictionary.csv')

pkC_max = PkParameterInfo$new("C_max", displayName = "C_max", displayUnit = "µg/l")
pkC_max_norm = PkParameterInfo$new("C_max_norm", displayName = "C_max_norm", displayUnit = "kg/l")
pkt_max = PkParameterInfo$new("t_max", displayName = "t_max", displayUnit = "h")
pkC_tEnd = PkParameterInfo$new("C_tEnd", displayName = "C_tEnd", displayUnit = "µg/l")
pkAUC_tEnd = PkParameterInfo$new("AUC_tEnd", displayName = "AUC", displayUnit = "µg*h/l")
pkAUC_tEnd_norm = PkParameterInfo$new("AUC_tEnd_norm", displayName = "AUC_norm", displayUnit = "kg*h/l")
pkAUC_inf = PkParameterInfo$new("AUC_inf", displayName = "AUC_inf", displayUnit = "µg*h/l")
pkAUC_inf_norm = PkParameterInfo$new("AUC_inf_norm", displayName = "AUC_inf_norm", displayUnit = "kg*h/l")
pkMRT = PkParameterInfo$new("MRT", displayName = "MRT", displayUnit = "h")
pkThalf = PkParameterInfo$new("Thalf", displayName = "Thalf", displayUnit = "h")
pkCL = PkParameterInfo$new("CL", displayName = "CL", displayUnit = "ml/min/kg")
pkVss = PkParameterInfo$new("Vss", displayName = "Vss", displayUnit = "ml/kg")
pkVd = PkParameterInfo$new("Vd", displayName = "Vd", displayUnit = "ml/kg")
pkC_max_t1_t2 = PkParameterInfo$new("C_max_tD1_tD2", displayName = "C_max_t1_t2", displayUnit = "µg/l")
pkC_max_t1_t2_norm = PkParameterInfo$new("C_max_tD1_tD2_norm", displayName = "C_max_t1_t2_norm", displayUnit = "kg/l")
pkC_max_tLast_tEnd = PkParameterInfo$new("C_max_tDLast_tEnd", displayName = "C_max_tLast_tEnd", displayUnit = "µg/l")
pkC_max_tLast_tEnd_norm = PkParameterInfo$new("C_max_tDLast_tEnd_norm", displayName = "C_max_tLast_tEnd_norm", displayUnit = "kg/l")
pkt_max_t1_t2 = PkParameterInfo$new("t_max_tD1_tD2", displayName = "t_max_t1_t2", displayUnit = "h")
pkt_max_tLast_tEnd = PkParameterInfo$new("t_max_tDLast_tEnd", displayName = "t_max_tLast_tEnd", displayUnit = "h")
pkC_trough_t2 = PkParameterInfo$new("C_trough_tD2", displayName = "C_trough_t2", displayUnit = "µg/l")
pkC_trough_tLast = PkParameterInfo$new("C_trough_tDLast", displayName = "C_trough_tLast", displayUnit = "µg/l")
pkAUC_t1_t2 = PkParameterInfo$new("AUC_tD1_tD2", displayName = "AUC_t1_t2", displayUnit = "µg*h/l")
pkAUC_t1_t2_norm = PkParameterInfo$new("AUC_tD1_tD2_norm", displayName = "AUC_t1_t2_norm", displayUnit = "kg*h/l")
pkAUC_tLast_minus_1_tLast = PkParameterInfo$new("AUC_tDLast_minus_1_tDLast", displayName = "AUC_tLast_minus_1_tLast", displayUnit = "µg*h/l")
pkAUC_tLast_minus_1_tLast_norm = PkParameterInfo$new("AUC_tDLast_minus_1_tDLast_norm", displayName = "AUC_tLast_minus_1_tLast_norm", displayUnit = "kg*h/l")
pkAUC_inf_t1 = PkParameterInfo$new("AUC_inf_tD1", displayName = "AUC_inf_t1", displayUnit = "µg*h/l")
pkAUC_inf_t1_norm = PkParameterInfo$new("AUC_inf_tD1_norm", displayName = "AUC_inf_t1_norm", displayUnit = "kg*h/l")
pkAUC_inf_tLast = PkParameterInfo$new("AUC_inf_tDLast", displayName = "AUC_inf_tLast", displayUnit = "µg*h/l")
pkAUC_inf_tLast_norm = PkParameterInfo$new("AUC_inf_tDLast_norm", displayName = "AUC_inf_tLast_norm", displayUnit = "kg*h/l")
pkThalf_tLast_tEnd = PkParameterInfo$new("Thalf_tDLast_tEnd", displayName = "Thalf_tLast_tEnd", displayUnit = "h")

pkVenousSingle = c(pkC_max, pkC_max_norm, pkt_max, pkC_tEnd, pkAUC_tEnd, pkAUC_tEnd_norm, pkAUC_inf, pkAUC_inf_norm, pkMRT, pkThalf, pkCL, pkVss, pkVd)
pkVenousMultiple = c(pkC_max, pkC_max_norm, pkC_max_t1_t2, pkC_max_t1_t2_norm, pkC_max_tLast_tEnd, pkC_max_tLast_tEnd_norm, pkt_max, pkt_max_t1_t2, pkt_max_tLast_tEnd,
                     pkC_trough_t2, pkC_trough_tLast, pkAUC_t1_t2, pkAUC_t1_t2_norm, pkAUC_tLast_minus_1_tLast, pkAUC_tLast_minus_1_tLast_norm, pkAUC_inf_t1, 
                     pkAUC_inf_t1_norm, pkAUC_inf_tLast, pkAUC_inf_tLast_norm, pkMRT, pkThalf, pkThalf_tLast_tEnd)

simulationSet1 <- SimulationSet$new(simulationSetName = 'Raltegravir 10 mg (lactose formulation)', 
                                    simulationName = "Raltegravir 10 mg   (lactose formulation)",
                                    simulationFile = file.path(workflowDir, "Models", "Raltegravir 10 mg   (lactose formulation).pkml"),
                                    outputs = outputVenousBlood('Grouping=="10mg_"', 'Observed_Raltegravir 10 mg (lactose formulation)',  pkVenousSingle), 
                                    observedDataFile = dataFile, observedMetaDataFile = dictionaryFile)

simulationSet2 <- SimulationSet$new(simulationSetName = 'Raltegravir 25 mg (lactose formulation)', 
                                    simulationName = "Raltegravir 25 mg  (lactose formulation)",
                                    simulationFile = file.path(workflowDir, "Models", "Raltegravir 25 mg  (lactose formulation).pkml"),
                                    outputs = outputVenousBlood('Grouping=="25mg"', 'Observed_Raltegravir 25 mg (lactose formulation)',  pkVenousSingle), 
                                    observedDataFile = dataFile, observedMetaDataFile = dictionaryFile)

simulationSet3 <- SimulationSet$new(simulationSetName = 'Raltegravir 50 mg (lactose formulation)', 
                                    simulationName = "Raltegravir 50 mg  (lactose formulation)",
                                    simulationFile = file.path(workflowDir, "Models", "Raltegravir 50 mg  (lactose formulation).pkml"),
                                    outputs = outputVenousBlood('Grouping=="50mg"', 'Observed_Raltegravir 50 mg (lactose formulation)',  pkVenousSingle), 
                                    observedDataFile = dataFile, observedMetaDataFile = dictionaryFile)

simulationSet4 <- SimulationSet$new(simulationSetName = 'Raltegravir 100 mg (lactose formulation)', 
                                    simulationName = "Raltegravir 100 mg  (lactose formulation)",
                                    simulationFile = file.path(workflowDir, "Models", "Raltegravir 100 mg  (lactose formulation).pkml"),
                                    outputs = outputVenousBlood('Grouping=="100mg"', 'Observed_Raltegravir 100 mg (lactose formulation)',  pkVenousSingle), 
                                    observedDataFile = dataFile, observedMetaDataFile = dictionaryFile)

simulationSet5 <- SimulationSet$new(simulationSetName = 'Raltegravir 200 mg (lactose formulation)', 
                                    simulationName = "Raltegravir 200 mg   (lactose formulation)",
                                    simulationFile = file.path(workflowDir, "Models", "Raltegravir 200 mg   (lactose formulation).pkml"),
                                    outputs = outputVenousBlood('Grouping=="200mg"', 'Observed_Raltegravir 200 mg (lactose formulation)',  pkVenousSingle), 
                                    observedDataFile = dataFile, observedMetaDataFile = dictionaryFile)

simulationSet6 <- SimulationSet$new(simulationSetName = 'Raltegravir 400mg (lactose formulation)', 
                                    simulationName = "Raltegravir 400mg (lactose formulation)",
                                    simulationFile = file.path(workflowDir, "Models", "Raltegravir 400mg (lactose formulation).pkml"),
                                    outputs = outputVenousBlood('Grouping=="400mg"', 'Observed_Raltegravir 400mg (lactose formulation)',  pkVenousSingle), 
                                    observedDataFile = dataFile, observedMetaDataFile = dictionaryFile)

simulationSet7 <- SimulationSet$new(simulationSetName = 'Raltegravir 800 mg (lactose formulation)', 
                                    simulationName = "Raltegravir 800 mg  (lactose formulation)",
                                    simulationFile = file.path(workflowDir, "Models", "Raltegravir 800 mg  (lactose formulation).pkml"),
                                    outputs = outputVenousBlood('Grouping=="800mg"', 'Observed_Raltegravir 800 mg (lactose formulation)',  pkVenousSingle), 
                                    observedDataFile = dataFile, observedMetaDataFile = dictionaryFile)

simulationSet8 <- SimulationSet$new(simulationSetName = 'Raltegravir 1200 mg (lactose formulation)', 
                                    simulationName = "Raltegravir 1200 mg   (lactose formulation)",
                                    simulationFile = file.path(workflowDir, "Models", "Raltegravir 1200 mg   (lactose formulation).pkml"),
                                    outputs = outputVenousBlood('Grouping=="1200mg"', 'Observed_Raltegravir 1200 mg (lactose formulation)',  pkVenousSingle), 
                                    observedDataFile = dataFile, observedMetaDataFile = dictionaryFile)

simulationSet9 <- SimulationSet$new(simulationSetName = 'Raltegravir 1600 mg (lactose formulation)', 
                                    simulationName = "Raltegravir 1600 mg  (lactose formulation)",
                                    simulationFile = file.path(workflowDir, "Models", "Raltegravir 1600 mg  (lactose formulation).pkml"),
                                    outputs = outputVenousBlood('Grouping=="1600mg"', 'Observed_Raltegravir 1600 mg (lactose formulation)',  pkVenousSingle), 
                                    observedDataFile = dataFile, observedMetaDataFile = dictionaryFile)

simulationSet10 <- SimulationSet$new(simulationSetName = 'Raltegravir 100 mg filmcoated tablet md', 
                                     simulationName = "Raltegravir 100 mg filmcoated tablet md",
                                     simulationFile = file.path(workflowDir, "Models", "Raltegravir 100 mg filmcoated tablet md.pkml"),
                                     outputs = outputVenousBlood('Grouping=="100mg_FCT_MD"', 'Observed_Raltegravir 100 mg filmcoated tablet md',  pkVenousMultiple), 
                                     observedDataFile = dataFile, observedMetaDataFile = dictionaryFile)

simulationSet11 <- SimulationSet$new(simulationSetName = 'Raltegravir 200 mg filmcoated tablet md', 
                                     simulationName = "Raltegravir 200 mg filmcoated tablet md",
                                     simulationFile = file.path(workflowDir, "Models", "Raltegravir 200 mg filmcoated tablet md.pkml"),
                                     outputs = outputVenousBlood('Grouping=="200mg_FCT_MD"', 'Observed_Raltegravir 200 mg filmcoated tablet md',  pkVenousMultiple), 
                                     observedDataFile = dataFile, observedMetaDataFile = dictionaryFile)

simulationSet12 <- SimulationSet$new(simulationSetName = 'Filmcoated_tablet_400mg_sd', 
                                     simulationName = "Raltegravir 400mg filmcoated tablet",
                                     simulationFile = file.path(workflowDir, "Models", "Raltegravir 400mg filmcoated tablet.pkml"),
                                     outputs = outputVenousBlood('Grouping=="400mg_FCT"', 'Observed_Raltegravir 400mg filmcoated tablet',  pkVenousSingle), 
                                     observedDataFile = dataFile, observedMetaDataFile = dictionaryFile)

simulationSet13 <- SimulationSet$new(simulationSetName = 'Raltegravir 400 mg filmcoated tablet md', 
                                     simulationName = "Raltegravir 400 mg filmcoated tablet md",
                                     simulationFile = file.path(workflowDir, "Models", "Raltegravir 400 mg filmcoated tablet md.pkml"),
                                     outputs = outputVenousBlood('Grouping=="400mg_FCT_MD"', 'Observed_Raltegravir 400 mg filmcoated tablet md',  pkVenousMultiple), 
                                     observedDataFile = dataFile, observedMetaDataFile = dictionaryFile)

simulationSet14 <- SimulationSet$new(simulationSetName = 'Raltegravir 400mg chewable fasted', 
                                     simulationName = "Raltegravir 400mg chewable fasted",
                                     simulationFile = file.path(workflowDir, "Models", "Raltegravir 400mg chewable fasted.pkml"),
                                     outputs = outputVenousBlood('Grouping=="Chewable_tablet_fasted"', 'Observed_Raltegravir 400mg chewable fasted',  pkVenousSingle), 
                                     observedDataFile = dataFile, observedMetaDataFile = dictionaryFile)

simulationSet15 <- SimulationSet$new(simulationSetName = 'Raltegravir 400mg chewable fed', 
                                     simulationName = "Raltegravir 400mg chewable fed",
                                     simulationFile = file.path(workflowDir, "Models", "Raltegravir 400mg chewable fed.pkml"),
                                     outputs = outputVenousBlood('Grouping=="Chewable_tablet_fed"', 'Observed_Raltegravir 400mg chewable fed',  pkVenousSingle), 
                                     observedDataFile = dataFile, observedMetaDataFile = dictionaryFile)

simulationSet16 <- SimulationSet$new(simulationSetName = 'Raltegravir 400mg (granules in suspension)', 
                                     simulationName = "Raltegravir 400mg (granules in suspension)",
                                     simulationFile = file.path(workflowDir, "Models", "Raltegravir 400mg (granules in suspension).pkml"),
                                     outputs = outputVenousBlood('Grouping=="granules_suspension"', 'Observed_Raltegravir 400mg (granules in suspension)',  pkVenousSingle), 
                                     observedDataFile = dataFile, observedMetaDataFile = dictionaryFile)


meanModelWorkflow <- MeanModelWorkflow$new(simulationSets = list(simulationSet1, simulationSet2, simulationSet3, simulationSet4, simulationSet5, simulationSet6, 
                                                                  simulationSet7, simulationSet8, simulationSet9, simulationSet10, simulationSet11, 
																  simulationSet12, simulationSet13, simulationSet14, simulationSet15, simulationSet16), 
                                           workflowFolder = outputDir)

#meanModelWorkflow <- MeanModelWorkflow$new(simulationSets = list(simulationSet1, simulationSet10), workflowFolder = outputDir)

meanModelWorkflow$inactivateTasks(meanModelWorkflow$getAllTasks())
meanModelWorkflow$activateTasks("simulate")
meanModelWorkflow$activateTasks("plotAbsorption")
meanModelWorkflow$activateTasks("plotMassBalance")
meanModelWorkflow$activateTasks("plotGoF")
meanModelWorkflow$activateTasks("meanModelPKParameters")
meanModelWorkflow$activateTasks("plotPKParameters")
#meanModelWorkflow$activateTasks("meanModelSensitivityAnalysis")
#meanModelWorkflow$activateTasks("plotSensitivity")

meanModelWorkflow$meanModelSensitivityAnalysis$settings$showProgress = TRUE
meanModelWorkflow$meanModelSensitivityAnalysis$settings$variableParameterPaths <- c(
  "Raltegravir|Lipophilicity", 
  "Raltegravir|Specific intestinal permeability (transcellular)",  
  "Raltegravir-UGT1A9-Kassahun 2007|In vitro Vmax for liver microsomes",
  "Raltegravir-UGT1A1-Kassahun 2007|In vitro Vmax for liver microsomes"
  )

meanModelWorkflow$runWorkflow()
