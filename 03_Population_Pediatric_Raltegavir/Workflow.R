outputVenousBlood <- function(subFilter, dataDisplayName, pkParametersVenousBlood)
{
  return (Output$new(path = "Organism|PeripheralVenousBlood|Raltegravir|Plasma (Peripheral Venous Blood)", displayName = "Raltegravir", displayUnit = "µg/l", 
                     pkParameters = pkParametersVenousBlood,
                     dataSelection = paste0('OUTPUT=="Raltegravir_PLASMA" & ', subFilter),
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

pkVenousSingle = c(pkC_max, pkC_max_norm, pkt_max, pkC_tEnd, pkAUC_tEnd, pkAUC_tEnd_norm, pkAUC_inf, pkAUC_inf_norm, pkMRT, pkThalf, pkCL, pkVss, pkVd)

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

popWorkFlow$simulate$settings$showProgress = TRUE
#popWorkFlow$simulate$settings$numberOfCores = parallel::detectCores()

popWorkFlow$calculateSensitivity$settings$showProgress = TRUE
#popWorkFlow$calculateSensitivity$settings$numberOfCores = parallel::detectCores()


popWorkFlow$inactivateTasks(popWorkFlow$getAllTasks())
popWorkFlow$activateTasks("simulate")
popWorkFlow$activateTasks("plotDemography")
popWorkFlow$activateTasks("plotTimeProfilesAndResiduals")
popWorkFlow$activateTasks("calculatePKParameters")
popWorkFlow$activateTasks("plotPKParameters")
popWorkFlow$activateTasks("calculateSensitivity")
popWorkFlow$activateTasks("plotSensitivity")

popWorkFlow$calculateSensitivity$settings$variableParameterPaths <- c(
  "Raltegravir|Lipophilicity", 
  "Raltegravir|Specific intestinal permeability (transcellular)",  
  "Raltegravir-UGT1A9-Kassahun 2007|In vitro Vmax for liver microsomes",
  "Raltegravir-UGT1A1-Kassahun 2007|In vitro Vmax for liver microsomes"
  )

popWorkFlow$runWorkflow()
