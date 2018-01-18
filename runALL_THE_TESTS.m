try
    import('matlab.unittest.TestRunner');
    import('matlab.unittest.plugins.XMLPlugin');
    import('matlab.unittest.plugins.ToFile');
    import('matlab.unittest.plugins.CodeCoveragePlugin');
    import('matlab.unittest.plugins.codecoverage.CoberturaFormat');

    ws = getenv('WORKSPACE');
    addpath(ws);
    
    tests = fullfile(ws, 'unittest');
    suite = testsuite(tests);

    % Create and configure the runner
    runner = TestRunner.withTextOutput('Verbosity',3);

    % Add the XML plugin
    resultsDir = fullfile(ws, 'testresults');
    mkdir(resultsDir);
    
    resultsFile = fullfile(resultsDir, 'testResults.xml');
    runner.addPlugin(XMLPlugin.producingJUnitFormat(resultsFile));
   
    coverageFile = fullfile(resultsDir, 'cobertura.xml');
    runner.addPlugin(CodeCoveragePlugin.forFolder(ws,...
        'Producing', CoberturaFormat(coverageFile)));
 
    results = runner.run(suite) 
catch e
    disp(getReport(e,'extended'));
    exit(1);
end
quit('force');

