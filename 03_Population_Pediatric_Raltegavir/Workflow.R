outputVenousBlood <- function(subFilter, dataDisplayName, pkParametersVenousBlood)
{
  return (Output$new(path = "Organism|PeripheralVenousBlood|Raltegravir|Plasma (Peripheral Venous Blood)", displayName = "Raltegravir", displayUnit = "µg/l", 
                     pkParameters = pkParametersVenousBlood,
                     dataFilter = paste0('OUTPUT=="Raltegravir_PLASMA" & ', subFilter),
                     dataDisplayName = dataDisplayName))
}

library("ospsuite.reportingengine")
Sys.setenv(LANG = "en")
ospsuite::removeAllUserDefinedPKParameters()

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
#pkC_max_t1_t2 = PkParameterInfo$new("C_max_tD1_tD2", displayName = "C_max_t1_t2", displayUnit = "µg/l")
#pkC_max_t1_t2_norm = PkParameterInfo$new("C_max_tD1_tD2_norm", displayName = "C_max_t1_t2_norm", displayUnit = "kg/l")
#pkC_max_tLast_tEnd = PkParameterInfo$new("C_max_tDLast_tEnd", displayName = "C_max_tLast_tEnd", displayUnit = "µg/l")
#pkC_max_tLast_tEnd_norm = PkParameterInfo$new("C_max_tDLast_tEnd_norm", displayName = "C_max_tLast_tEnd_norm", displayUnit = "kg/l")
#pkt_max_t1_t2 = PkParameterInfo$new("t_max_tD1_tD2", displayName = "t_max_t1_t2", displayUnit = "h")
#pkt_max_tLast_tEnd = PkParameterInfo$new("t_max_tDLast_tEnd", displayName = "t_max_tLast_tEnd", displayUnit = "h")
#pkC_trough_t2 = PkParameterInfo$new("C_trough_tD2", displayName = "C_trough_t2", displayUnit = "µg/l")
#pkC_trough_tLast = PkParameterInfo$new("C_trough_tDLast", displayName = "C_trough_tLast", displayUnit = "µg/l")
#pkAUC_t1_t2 = PkParameterInfo$new("AUC_tD1_tD2", displayName = "AUC_t1_t2", displayUnit = "µg*h/l")
#pkAUC_t1_t2_norm = PkParameterInfo$new("AUC_tD1_tD2_norm", displayName = "AUC_t1_t2_norm", displayUnit = "kg*h/l")
#pkAUC_tLast_minus_1_tLast = PkParameterInfo$new("AUC_tDLast_minus_1_tDLast", displayName = "AUC_tLast_minus_1_tLast", displayUnit = "µg*h/l")
#pkAUC_tLast_minus_1_tLast_norm = PkParameterInfo$new("AUC_tDLast_minus_1_tDLast_norm", displayName = "AUC_tLast_minus_1_tLast_norm", displayUnit = "kg*h/l")
#pkAUC_inf_t1 = PkParameterInfo$new("AUC_inf_tD1", displayName = "AUC_inf_t1", displayUnit = "µg*h/l")
#pkAUC_inf_t1_norm = PkParameterInfo$new("AUC_inf_tD1_norm", displayName = "AUC_inf_t1_norm", displayUnit = "kg*h/l")
#pkAUC_inf_tLast = PkParameterInfo$new("AUC_inf_tDLast", displayName = "AUC_inf_tLast", displayUnit = "µg*h/l")
#pkAUC_inf_tLast_norm = PkParameterInfo$new("AUC_inf_tDLast_norm", displayName = "AUC_inf_tLast_norm", displayUnit = "kg*h/l")
#pkThalf_tLast_tEnd = PkParameterInfo$new("Thalf_tDLast_tEnd", displayName = "Thalf_tLast_tEnd", displayUnit = "h")

pkVenousSingle = c(pkC_max, pkC_max_norm, pkt_max, pkC_tEnd, pkAUC_tEnd, pkAUC_tEnd_norm, pkAUC_inf, pkAUC_inf_norm, pkMRT, pkThalf, pkCL, pkVss, pkVd)
#pkVenousSingle = c(pkC_max, pkC_max_norm, pkt_max, pkC_tEnd, pkAUC_tEnd, pkAUC_tEnd_norm, pkAUC_inf, pkAUC_inf_norm, pkMRT, pkThalf, pkVss)


#pkVenousMultiple = c(pkC_max, pkC_max_norm, pkC_max_t1_t2, pkC_max_t1_t2_norm, pkC_max_tLast_tEnd, pkC_max_tLast_tEnd_norm, pkt_max, pkt_max_t1_t2, pkt_max_tLast_tEnd,
#                     pkC_trough_t2, pkC_trough_tLast, pkAUC_t1_t2, pkAUC_t1_t2_norm, pkAUC_tLast_minus_1_tLast, pkAUC_tLast_minus_1_tLast_norm, pkAUC_inf_t1, 
#                     pkAUC_inf_t1_norm, pkAUC_inf_tLast, pkAUC_inf_tLast_norm, pkMRT, pkThalf, pkThalf_tLast_tEnd)

simSet1 <- PopulationSimulationSet$new(simulationSetName = 'Larson 2013 8y-18y 400mg FCT meal', 
                                       simulationName = "Larson 2013 8-18y meal",
                                       simulationFile = file.path(workflowDir, "Models", "Larson 2013 8-18y meal.pkml"),
                                       populationFile = file.path(workflowDir, "Models", "Larson 2013 8-18y meal-Population.csv"),
                                       populationName = "Pediatric population 8y-18y", 
                                       referencePopulation = FALSE,
                                       studyDesignFile = NULL,
                                       outputs = outputVenousBlood('Grouping=="8-18y"', 'Observed_Raltegravir 10 mg (lactose formulation)',  pkVenousSingle), 
                                       observedDataFile = dataFile, observedMetaDataFile = dictionaryFile)

simSet2 <- PopulationSimulationSet$new(simulationSetName = 'Filmcoated_tablet_400mg_sd', 
                                       simulationName = "Raltegravir 400mg filmcoated tablet",
                                       simulationFile = file.path(workflowDir, "Models", "Raltegravir 400mg filmcoated tablet.pkml"),
                                       populationFile = file.path(workflowDir, "Models", "Raltegravir Adult Population.csv"),
                                       populationName = "Healthy Adult Population", 
                                       referencePopulation = TRUE,
                                       studyDesignFile = NULL,
                                       outputs = outputVenousBlood('Grouping=="400mg_FCT"', 'Observed_Raltegravir 400mg filmcoated tablet',  pkVenousSingle), 
                                       observedDataFile = dataFile, observedMetaDataFile = dictionaryFile)

popWorkFlow <- PopulationWorkflow$new(workflowType = PopulationWorkflowTypes$pediatric, simulationSets = list(simSet1, simSet2), workflowFolder = outputDir)
#popWorkFlow <- PopulationWorkflow$new(workflowType = PopulationWorkflowTypes$pediatric, simulationSets = list(simSet1), workflowFolder = outputDir)

popWorkFlow$simulatePopulation$settings$showProgress = TRUE
#popWorkFlow$simulatePopulation$settings$numberOfCores = parallel::detectCores()

popWorkFlow$populationSensitivityAnalysis$settings$showProgress = TRUE
#popWorkFlow$populationSensitivityAnalysis$settings$numberOfCores = parallel::detectCores()


popWorkFlow$inactivateTasks(popWorkFlow$getAllTasks())
#popWorkFlow$activateTasks("simulatePopulation")
popWorkFlow$activateTasks("plotDemography")
popWorkFlow$activateTasks("plotGoF")
#popWorkFlow$activateTasks("populationPKParameters")
popWorkFlow$activateTasks("plotPKParameters")
#popWorkFlow$activateTasks("populationSensitivityAnalysis")
popWorkFlow$activateTasks("plotSensitivity")

popWorkFlow$populationSensitivityAnalysis$settings$variableParameterPaths <- c(
  "Raltegravir|Lipophilicity", 
  "Raltegravir|Specific intestinal permeability (transcellular)",  
  "Raltegravir-UGT1A9-Kassahun 2007|In vitro Vmax for liver microsomes",
  "Raltegravir-UGT1A1-Kassahun 2007|In vitro Vmax for liver microsomes"
  )

popWorkFlow$runWorkflow()
