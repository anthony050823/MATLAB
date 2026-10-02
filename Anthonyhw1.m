function Anthonyhw1

WHITE = [1 1 1];
BLACK = [0.05 0.05 0.05];
NAVY  = [0.03 0.12 0.28];
BLUE  = [0.10 0.42 0.72];
GRAY  = [0.45 0.45 0.45];

FONT = 'Arial';

FONT_SMALL  = 14;
FONT_NORMAL = 16;
FONT_LARGE  = 20;
FONT_TITLE  = 32;

fig = uifigure( ...
    'Name','MATLAB #4', ...
    'Position',[40 30 1600 920], ...
    'Color',WHITE);

mainGrid = uigridlayout(fig,[2 2]);
mainGrid.RowHeight = {110,'1x'};
mainGrid.ColumnWidth = {420,'1x'};
mainGrid.Padding = [16 16 16 16];
mainGrid.RowSpacing = 14;
mainGrid.ColumnSpacing = 14;

header = uipanel(mainGrid, ...
    'BackgroundColor',WHITE, ...
    'BorderType','none');

header.Layout.Row = 1;
header.Layout.Column = [1 2];

headerGrid = uigridlayout(header,[1 2]);
headerGrid.ColumnWidth = {'1x',260};
headerGrid.Padding = [28 12 28 12];
headerGrid.ColumnSpacing = 20;

titleLabel = uilabel(headerGrid, ...
    'Text','MATLAB #4', ...
    'FontName',FONT, ...
    'FontSize',FONT_TITLE, ...
    'FontWeight','bold', ...
    'FontColor',NAVY);

titleLabel.Layout.Column = 1;

modeSwitch = uiswitch(headerGrid,'slider');
modeSwitch.Items = {'Ramp','Collision'};
modeSwitch.Value = 'Ramp';
modeSwitch.FontName = FONT;
modeSwitch.FontSize = 20;
modeSwitch.FontWeight = 'bold';
modeSwitch.FontColor = BLACK;
modeSwitch.Layout.Column = 2;

controlPanel = uipanel(mainGrid, ...
    'BackgroundColor',WHITE, ...
    'BorderType','none');

controlPanel.Layout.Row = 2;
controlPanel.Layout.Column = 1;

controlGrid = uigridlayout(controlPanel,[4 1]);
controlGrid.RowHeight = {'1x',190,68,56};
controlGrid.Padding = [0 0 0 0];
controlGrid.RowSpacing = 12;

rampPanel = uipanel(controlGrid, ...
    'Title','SLIDING BOX SETUP', ...
    'FontName',FONT, ...
    'FontSize',FONT_LARGE, ...
    'FontWeight','bold', ...
    'ForegroundColor',NAVY, ...
    'BackgroundColor',WHITE);

rampPanel.Layout.Row = 1;

rg = uigridlayout(rampPanel,[13 2]);
rg.ColumnWidth = {'1x',145};
rg.RowHeight = repmat({38},1,13);
rg.Padding = [12 12 12 12];
rg.RowSpacing = 5;

rampMass = addField(rg,1,'Mass, m [kg]',5);
rampMu   = addField(rg,2,'Friction coefficient, μ',0.20);
rampAng  = addField(rg,3,'Ramp angle, θ [deg]',25);
rampG    = addField(rg,4,'Gravity, g [m/s²]',9.81);

makeLabel(rg,5,'Coordinate system');

rampCoord = uidropdown(rg, ...
    'Items',{'Along Ramp','Horizontal X'}, ...
    'Value','Along Ramp', ...
    'FontName',FONT, ...
    'FontSize',FONT_NORMAL, ...
    'FontWeight','bold', ...
    'BackgroundColor',WHITE, ...
    'FontColor',BLACK);

rampCoord.Layout.Row = 5;
rampCoord.Layout.Column = 2;

rampX0 = addField(rg,6,'Initial position [m]',0);
rampV0 = addField(rg,7,'Initial velocity [m/s]',7);

makeLabel(rg,8,'Stopping condition');

rampStopType = uidropdown(rg, ...
    'Items',{'Simulation Time','Position Reaches','Velocity Reaches'}, ...
    'Value','Simulation Time', ...
    'FontName',FONT, ...
    'FontSize',FONT_NORMAL, ...
    'FontWeight','bold', ...
    'BackgroundColor',WHITE, ...
    'FontColor',BLACK);

rampStopType.Layout.Row = 8;
rampStopType.Layout.Column = 2;

rampStopValue = addField(rg,9,'Target value',8);
rampTmax      = addField(rg,10,'Maximum time [s]',10);
rampDt        = addField(rg,11,'Time step [s]',0.01);

directionInfo = uilabel(rg, ...
    'Text','+ velocity = uphill', ...
    'FontName',FONT, ...
    'FontSize',FONT_SMALL, ...
    'FontAngle','italic', ...
    'FontColor',BLACK);

directionInfo.Layout.Row = 12;
directionInfo.Layout.Column = [1 2];

rampInfo = uilabel(rg, ...
    'Text','Friction always opposes motion.', ...
    'FontName',FONT, ...
    'FontSize',FONT_SMALL, ...
    'FontColor',BLACK);

rampInfo.Layout.Row = 13;
rampInfo.Layout.Column = [1 2];

collisionPanel = uipanel(controlGrid, ...
    'Title','1D COLLISION SETUP', ...
    'FontName',FONT, ...
    'FontSize',FONT_LARGE, ...
    'FontWeight','bold', ...
    'ForegroundColor',NAVY, ...
    'BackgroundColor',WHITE, ...
    'Visible','off');

collisionPanel.Layout.Row = 1;

cg = uigridlayout(collisionPanel,[16 2]);
cg.ColumnWidth = {'1x',145};
cg.RowHeight = repmat({36},1,16);
cg.Padding = [12 12 12 12];
cg.RowSpacing = 3;

m1Field = addField(cg,1,'Object 1 mass [kg]',2);
m2Field = addField(cg,2,'Object 2 mass [kg]',3);

x1Field = addField(cg,3,'Object 1 position [m]',-3);
x2Field = addField(cg,4,'Object 2 position [m]',3);

v1Field = addField(cg,5,'Object 1 velocity [m/s]',5);
v2Field = addField(cg,6,'Object 2 velocity [m/s]',-1);

collisionMu = addField(cg,7,'Surface friction, μ',0);
collisionG  = addField(cg,8,'Gravity, g [m/s²]',9.81);

makeLabel(cg,9,'Collision type');

collisionType = uidropdown(cg, ...
    'Items',{ ...
    'Perfectly Elastic', ...
    'Perfectly Inelastic', ...
    'Imperfectly Inelastic'}, ...
    'Value','Perfectly Elastic', ...
    'FontName',FONT, ...
    'FontSize',FONT_NORMAL, ...
    'FontWeight','bold', ...
    'BackgroundColor',WHITE, ...
    'FontColor',BLACK);

collisionType.Layout.Row = 9;
collisionType.Layout.Column = 2;

restitutionField = addField(cg,10,'Restitution, e',1);
restitutionField.Enable = 'off';

makeLabel(cg,11,'Stopping condition');

collisionStop = uidropdown(cg, ...
    'Items',{ ...
    'Simulation Time', ...
    'Object 1 Position', ...
    'Object 2 Position', ...
    'Object 1 Velocity', ...
    'Object 2 Velocity'}, ...
    'Value','Simulation Time', ...
    'FontName',FONT, ...
    'FontSize',FONT_NORMAL, ...
    'FontWeight','bold', ...
    'BackgroundColor',WHITE, ...
    'FontColor',BLACK);

collisionStop.Layout.Row = 11;
collisionStop.Layout.Column = 2;

collisionStopValue = addField(cg,12,'Target value',8);
collisionTmax      = addField(cg,13,'Maximum time [s]',10);
collisionDt        = addField(cg,14,'Time step [s]',0.005);

collisionNote = uilabel(cg, ...
    'Text','Momentum is conserved during impact.', ...
    'FontName',FONT, ...
    'FontSize',FONT_SMALL, ...
    'FontAngle','italic', ...
    'FontColor',BLACK);

collisionNote.Layout.Row = 15;
collisionNote.Layout.Column = [1 2];

collisionNote2 = uilabel(cg, ...
    'Text','Surface friction acts as an external force.', ...
    'FontName',FONT, ...
    'FontSize',FONT_SMALL, ...
    'FontColor',BLACK);

collisionNote2.Layout.Row = 16;
collisionNote2.Layout.Column = [1 2];

ledgerPanel = uipanel(controlGrid, ...
    'Title','RESULTS', ...
    'FontName',FONT, ...
    'FontSize',FONT_LARGE, ...
    'FontWeight','bold', ...
    'ForegroundColor',NAVY, ...
    'BackgroundColor',WHITE);

ledgerPanel.Layout.Row = 2;

ledger = uitextarea(ledgerPanel, ...
    'Position',[10 10 385 142], ...
    'Editable','off', ...
    'FontName',FONT, ...
    'FontSize',14, ...
    'BackgroundColor',WHITE, ...
    'FontColor',BLACK);

ledger.Value = {
    'Run a simulation to view'
    'initial and final conditions.'
    };


runButton = uibutton(controlGrid,'push', ...
    'Text','RUN SIMULATION', ...
    'FontName',FONT, ...
    'FontSize',21, ...
    'FontWeight','bold', ...
    'BackgroundColor',NAVY, ...
    'FontColor',WHITE);

runButton.Layout.Row = 3;

resetButton = uibutton(controlGrid,'push', ...
    'Text','RESET VIEW', ...
    'FontName',FONT, ...
    'FontSize',17, ...
    'FontWeight','bold', ...
    'BackgroundColor',BLACK, ...
    'FontColor',WHITE);

resetButton.Layout.Row = 4;

visualPanel = uipanel(mainGrid, ...
    'BackgroundColor',WHITE, ...
    'BorderType','none');

visualPanel.Layout.Row = 2;
visualPanel.Layout.Column = 2;

vg = uigridlayout(visualPanel,[2 3]);

vg.ColumnWidth = {'1.25x','1x','1x'};
vg.RowHeight = {'1x','1x'};
vg.Padding = [0 0 0 0];
vg.RowSpacing = 16;
vg.ColumnSpacing = 16;

simAx = uiaxes(vg);
simAx.Layout.Row = [1 2];
simAx.Layout.Column = 1;

posAx = uiaxes(vg);
posAx.Layout.Row = 1;
posAx.Layout.Column = 2;

speedAx = uiaxes(vg);
speedAx.Layout.Row = 1;
speedAx.Layout.Column = 3;

momentumAx = uiaxes(vg);
momentumAx.Layout.Row = 2;
momentumAx.Layout.Column = 2;

energyAx = uiaxes(vg);
energyAx.Layout.Row = 2;
energyAx.Layout.Column = 3;

axesList = [simAx posAx speedAx momentumAx energyAx];

for currentAx = axesList

    currentAx.Toolbar.Visible = 'off';

    currentAx.Color = WHITE;

    currentAx.XColor = BLACK;
    currentAx.YColor = BLACK;

    currentAx.FontName = FONT;
    currentAx.FontSize = 13;
    currentAx.FontWeight = 'normal';

    currentAx.GridColor = BLACK;
    currentAx.MinorGridColor = BLACK;

    currentAx.GridAlpha = 0.10;
    currentAx.MinorGridAlpha = 0.05;

    currentAx.LineWidth = 1;

    currentAx.Box = 'off';

    currentAx.XGrid = 'on';
    currentAx.YGrid = 'on';

    currentAx.XMinorGrid = 'on';
    currentAx.YMinorGrid = 'on';

    currentAx.TickDir = 'out';

end


setupBlankAxes();


modeSwitch.ValueChangedFcn = @(src,event) switchMode();
runButton.ButtonPushedFcn = @(src,event) runSimulation();
resetButton.ButtonPushedFcn = @(src,event) setupBlankAxes();
collisionType.ValueChangedFcn = @(src,event) updateRestitution();


    function field = addField(grid,row,labelText,value)

        lbl = uilabel(grid, ...
            'Text',labelText, ...
            'FontName',FONT, ...
            'FontSize',FONT_NORMAL, ...
            'FontWeight','bold', ...
            'FontColor',BLACK);

        lbl.Layout.Row = row;
        lbl.Layout.Column = 1;

        field = uieditfield(grid,'numeric', ...
            'Value',value, ...
            'FontName',FONT, ...
            'FontSize',FONT_NORMAL, ...
            'BackgroundColor',WHITE, ...
            'FontColor',BLACK);

        field.Layout.Row = row;
        field.Layout.Column = 2;

    end


    function lbl = makeLabel(grid,row,labelText)

        lbl = uilabel(grid, ...
            'Text',labelText, ...
            'FontName',FONT, ...
            'FontSize',FONT_NORMAL, ...
            'FontWeight','bold', ...
            'FontColor',BLACK);

        lbl.Layout.Row = row;
        lbl.Layout.Column = 1;

    end


    function switchMode()

        if strcmp(modeSwitch.Value,'Ramp')

            rampPanel.Visible = 'on';
            collisionPanel.Visible = 'off';

        else

            rampPanel.Visible = 'off';
            collisionPanel.Visible = 'on';

        end

        setupBlankAxes();

    end


    function updateRestitution()

        switch collisionType.Value

            case 'Perfectly Elastic'

                restitutionField.Value = 1;
                restitutionField.Enable = 'off';

            case 'Perfectly Inelastic'

                restitutionField.Value = 0;
                restitutionField.Enable = 'off';

            otherwise

                restitutionField.Enable = 'on';

        end

    end


    function runSimulation()

        runButton.Text = 'RUNNING...';
        runButton.Enable = 'off';

        drawnow;

        try

            if strcmp(modeSwitch.Value,'Ramp')

                runRamp();

            else

                runCollision();

            end

            runButton.Text = 'RUN AGAIN';
            runButton.Enable = 'on';

            showCompletePopup();

        catch ME

            runButton.Text = 'RUN SIMULATION';
            runButton.Enable = 'on';

            uialert(fig, ...
                ME.message, ...
                'Simulation Error', ...
                'Icon','error');

        end

    end


    function showCompletePopup()

        popup = uifigure( ...
            'Name','Complete', ...
            'Position',[650 420 430 220], ...
            'Color',WHITE, ...
            'Resize','off');

        popupGrid = uigridlayout(popup,[3 1]);

        popupGrid.RowHeight = {55,'1x',52};
        popupGrid.Padding = [30 20 30 20];
        popupGrid.RowSpacing = 8;

        popupTitle = uilabel(popupGrid, ...
            'Text','COMPLETE', ...
            'HorizontalAlignment','center', ...
            'FontName',FONT, ...
            'FontSize',25, ...
            'FontWeight','bold', ...
            'FontColor',BLACK);

        popupTitle.Layout.Row = 1;

        popupMessage = uilabel(popupGrid, ...
            'Text','Simulation completed successfully.', ...
            'HorizontalAlignment','center', ...
            'FontName',FONT, ...
            'FontSize',17, ...
            'FontColor',BLACK);

        popupMessage.Layout.Row = 2;

        closeButton = uibutton(popupGrid,'push', ...
            'Text','CLOSE', ...
            'FontName',FONT, ...
            'FontSize',16, ...
            'FontWeight','bold', ...
            'BackgroundColor',NAVY, ...
            'FontColor',WHITE, ...
            'ButtonPushedFcn',@(src,event) close(popup));

        closeButton.Layout.Row = 3;

    end

    function setupBlankAxes()

        for currentAx = axesList

            cla(currentAx);

            currentAx.Visible = 'on';

            currentAx.XTickMode = 'auto';
            currentAx.YTickMode = 'auto';

            currentAx.XGrid = 'on';
            currentAx.YGrid = 'on';

            currentAx.XMinorGrid = 'on';
            currentAx.YMinorGrid = 'on';

        end

        styleTitle(simAx,'SIMULATION');

        styleTitle(posAx,'POSITION');
        styleXAxis(posAx);

        styleTitle(speedAx,'SPEED');
        styleXAxis(speedAx);

        styleTitle(momentumAx,'VELOCITY / MOMENTUM');
        styleXAxis(momentumAx);

        styleTitle(energyAx,'ENERGY');
        styleXAxis(energyAx);

        ledger.Value = {
            'Run a simulation to view'
            'initial and final conditions.'
            };

    end


    function styleTitle(targetAx,titleText)

        title(targetAx,titleText, ...
            'Color',NAVY, ...
            'FontName',FONT, ...
            'FontSize',18, ...
            'FontWeight','bold', ...
            'Interpreter','none');

    end


    function styleXAxis(targetAx)

        xlabel(targetAx,'Time [s]', ...
            'FontName',FONT, ...
            'FontSize',14, ...
            'FontWeight','bold', ...
            'Color',BLACK, ...
            'Interpreter','none');

    end


    function styleYAxis(targetAx,labelText)

        ylabel(targetAx,labelText, ...
            'FontName',FONT, ...
            'FontSize',14, ...
            'FontWeight','bold', ...
            'Color',BLACK, ...
            'Interpreter','none');

    end

    function runRamp()

        m = rampMass.Value;
        mu = rampMu.Value;
        thetaDeg = rampAng.Value;
        g = rampG.Value;
        dt = rampDt.Value;
        tMax = rampTmax.Value;

        if m <= 0
            error('Mass must be greater than zero.');
        end

        if mu < 0
            error('Friction coefficient cannot be negative.');
        end

        if thetaDeg < 0 || thetaDeg >= 90
            error('Ramp angle must be between 0 and 90 degrees.');
        end

        if g <= 0
            error('Gravity must be positive.');
        end

        if dt <= 0 || tMax <= 0
            error('Time step and simulation time must be positive.');
        end


        theta = deg2rad(thetaDeg);

        inputX = rampX0.Value;
        inputV = rampV0.Value;


        if strcmp(rampCoord.Value,'Horizontal X')

            if abs(cos(theta)) < 1e-6

                error('Horizontal coordinate becomes singular near 90 degrees.');

            end

            s = inputX/cos(theta);
            v = inputV/cos(theta);

        else

            s = inputX;
            v = inputV;

        end


        sInitial = s;
        vInitial = v;


        Nmax = ceil(tMax/dt)+2;

        time = zeros(Nmax,1);

        sHist = zeros(Nmax,1);
        vHist = zeros(Nmax,1);

        KHist = zeros(Nmax,1);
        UHist = zeros(Nmax,1);
        DHist = zeros(Nmax,1);


        sHist(1) = s;
        vHist(1) = v;

        KHist(1) = 0.5*m*v^2;
        UHist(1) = m*g*s*sin(theta);


        dissipated = 0;

        n = 1;

        target = rampStopValue.Value;


        while time(n) < tMax

            n = n+1;

            tPrev = time(n-1);

            currentDt = min(dt,tMax-tPrev);

            sPrev = s;
            vPrev = v;

            gravityAlongRamp = -g*sin(theta);

            frictionMag = mu*g*cos(theta);

            velocityTolerance = 1e-8;


            if v > velocityTolerance

                accel = gravityAlongRamp-frictionMag;

            elseif v < -velocityTolerance

                accel = gravityAlongRamp+frictionMag;

            else

                if g*sin(theta) <= frictionMag

                    accel = 0;
                    v = 0;

                else

                    accel = -g*sin(theta)+frictionMag;

                end

            end


            vNew = v+accel*currentDt;


            if v ~= 0 && sign(vNew) ~= sign(v)

                vNew = 0;

            end


            sNew = s+0.5*(v+vNew)*currentDt;

            ds = sNew-s;


            dissipated = dissipated + ...
                mu*m*g*cos(theta)*abs(ds);


            s = sNew;
            v = vNew;


            time(n) = tPrev+currentDt;


            sHist(n) = s;
            vHist(n) = v;

            KHist(n) = 0.5*m*v^2;
            UHist(n) = m*g*s*sin(theta);
            DHist(n) = dissipated;


            shouldStop = false;


            switch rampStopType.Value

                case 'Position Reaches'

                    shouldStop = crossedValue( ...
                        displayRampPosition(sPrev,theta), ...
                        displayRampPosition(s,theta), ...
                        target);

                case 'Velocity Reaches'

                    oldVel = ...
                        displayRampVelocity(vPrev,theta);

                    newVel = ...
                        displayRampVelocity(v,theta);

                    shouldStop = crossedValue( ...
                        oldVel,newVel,target);

            end


            if shouldStop
                break;
            end

        end


        time = time(1:n);

        sHist = sHist(1:n);
        vHist = vHist(1:n);

        KHist = KHist(1:n);
        UHist = UHist(1:n);
        DHist = DHist(1:n);


        if strcmp(rampCoord.Value,'Horizontal X')

            posDisplay = sHist*cos(theta);

            coordinateName = 'Horizontal x';

        else

            posDisplay = sHist;

            coordinateName = 'Ramp coordinate s';

        end


        speedActual = abs(vHist);

        mechanical = KHist+UHist;

        accountingEnergy = mechanical+DHist;


        animateRamp(time,sHist,theta);



        cla(posAx);

        plot(posAx,time,posDisplay, ...
            'Color',NAVY, ...
            'LineWidth',2.3);

        styleTitle(posAx,'POSITION');

        styleXAxis(posAx);

        styleYAxis(posAx, ...
            [coordinateName ' [m]']);


        cla(speedAx);

        plot(speedAx,time,speedActual, ...
            'Color',BLUE, ...
            'LineWidth',2.3);

        styleTitle(speedAx,'SPEED');

        styleXAxis(speedAx);

        styleYAxis(speedAx,'Speed [m/s]');


        %% VELOCITY

        cla(momentumAx);

        hold(momentumAx,'on');

        plot(momentumAx,time,vHist, ...
            'Color',NAVY, ...
            'LineWidth',2.3);

        yline(momentumAx,0, ...
            '--', ...
            'Color',GRAY, ...
            'LineWidth',1.3);

        hold(momentumAx,'off');

        styleTitle(momentumAx,'VELOCITY');

        styleXAxis(momentumAx);

        styleYAxis(momentumAx,'Velocity [m/s]');


        cla(energyAx);

        hold(energyAx,'on');

        plot(energyAx,time,KHist, ...
            '-', ...
            'Color',NAVY, ...
            'LineWidth',2.4);

        plot(energyAx,time,UHist, ...
            '-', ...
            'Color',BLUE, ...
            'LineWidth',2.2);

        plot(energyAx,time,DHist, ...
            ':', ...
            'Color',GRAY, ...
            'LineWidth',2.2);

        plot(energyAx,time,accountingEnergy, ...
            '--', ...
            'Color',BLACK, ...
            'LineWidth',2.2);

        hold(energyAx,'off');

        styleTitle(energyAx,'ENERGY BALANCE');

        styleXAxis(energyAx);

        styleYAxis(energyAx,'Energy [J]');


        lgd = legend(energyAx, ...
            {'Kinetic','Potential','Friction loss','Total accounted'}, ...
            'Location','best');

        lgd.Box = 'off';
        lgd.FontName = FONT;
        lgd.FontSize = 12;
        lgd.FontWeight = 'normal';
        lgd.TextColor = BLACK;


        initialPosShown = ...
            displayRampPosition(sInitial,theta);

        finalPosShown = ...
            displayRampPosition(sHist(end),theta);

        initialVelShown = ...
            displayRampVelocity(vInitial,theta);

        finalVelShown = ...
            displayRampVelocity(vHist(end),theta);


        ledger.Value = {
            'RAMP RESULTS'
            ''
            sprintf('xi = %.3f m',initialPosShown)
            sprintf('xf = %.3f m',finalPosShown)
            sprintf('vi = %.3f m/s',initialVelShown)
            sprintf('vf = %.3f m/s',finalVelShown)
            ''
            sprintf('Ei = %.3f J',mechanical(1))
            sprintf('Ef = %.3f J',mechanical(end))
            sprintf('Friction loss = %.3f J',DHist(end))
            ''
            };

    end


    function outputX = displayRampPosition(s,theta)

        if strcmp(rampCoord.Value,'Horizontal X')

            outputX = s*cos(theta);

        else

            outputX = s;

        end

    end


    function outputV = displayRampVelocity(v,theta)

        if strcmp(rampCoord.Value,'Horizontal X')

            outputV = v*cos(theta);

        else

            outputV = v;

        end

    end


    function animateRamp(time,sHistory,theta)

        cla(simAx);


        sMin = min([sHistory(:);0]);

        sMax = max([sHistory(:);0]);


        span = max(sMax-sMin,4);


        sLo = sMin-0.25*span;

        sHi = sMax+0.25*span;


        xRamp = [sLo sHi]*cos(theta);

        yRamp = [sLo sHi]*sin(theta);


        plot(simAx,xRamp,yRamp, ...
            'Color',BLACK, ...
            'LineWidth',5);


        hold(simAx,'on');


        styleTitle(simAx,'SLIDING BOX');


        xlabel(simAx,'Horizontal position [m]', ...
            'FontName',FONT, ...
            'FontSize',14, ...
            'FontWeight','bold', ...
            'Color',BLACK, ...
            'Interpreter','none');


        styleYAxis(simAx,'Vertical position [m]');


        axis(simAx,'equal');


        xlim(simAx,[min(xRamp)-1 max(xRamp)+1]);

        ylim(simAx,[min(yRamp)-1 max(yRamp)+2]);


        boxSize = max(0.30,0.07*span);


        verts = boxVertices( ...
            sHistory(1), ...
            theta, ...
            boxSize);


        boxPatch = patch(simAx, ...
            verts(:,1), ...
            verts(:,2), ...
            NAVY, ...
            'EdgeColor',BLACK, ...
            'LineWidth',2);


        timeText = text(simAx, ...
            mean(xRamp), ...
            max(yRamp)+1.2, ...
            't = 0.00 s', ...
            'FontName',FONT, ...
            'FontSize',16, ...
            'FontWeight','bold', ...
            'Color',BLACK, ...
            'HorizontalAlignment','center');


        hold(simAx,'off');


        frameCount = ...
            min(150,length(time));


        frameIndices = ...
            unique(round(linspace( ...
            1,length(time),frameCount)));


        for k = frameIndices

            verts = boxVertices( ...
                sHistory(k), ...
                theta, ...
                boxSize);


            boxPatch.XData = verts(:,1);

            boxPatch.YData = verts(:,2);


            timeText.String = ...
                sprintf('t = %.2f s',time(k));


            drawnow limitrate;

        end

    end


    function verts = boxVertices(s,theta,L)

        tangent = ...
            [cos(theta) sin(theta)];

        normal = ...
            [-sin(theta) cos(theta)];


        center = ...
            s*tangent+(L/2)*normal;


        verts = [ ...
            center-L/2*tangent-L/2*normal;
            center+L/2*tangent-L/2*normal;
            center+L/2*tangent+L/2*normal;
            center-L/2*tangent+L/2*normal];

    end



    function runCollision()

        m1 = m1Field.Value;
        m2 = m2Field.Value;

        x1 = x1Field.Value;
        x2 = x2Field.Value;

        v1 = v1Field.Value;
        v2 = v2Field.Value;

        mu = collisionMu.Value;
        g = collisionG.Value;

        dt = collisionDt.Value;
        tMax = collisionTmax.Value;


        if m1 <= 0 || m2 <= 0

            error('Both masses must be greater than zero.');

        end


        if mu < 0

            error('Friction coefficient cannot be negative.');

        end


        if g <= 0

            error('Gravity must be positive.');

        end


        if dt <= 0 || tMax <= 0

            error('Time step and simulation time must be positive.');

        end


        switch collisionType.Value

            case 'Perfectly Elastic'

                e = 1;

            case 'Perfectly Inelastic'

                e = 0;

            otherwise

                e = restitutionField.Value;

                if e < 0 || e > 1

                    error( ...
                        'Coefficient of restitution must be between 0 and 1.');

                end

        end


        Nmax = ceil(tMax/dt)+2;


        time = zeros(Nmax,1);

        X1 = zeros(Nmax,1);
        X2 = zeros(Nmax,1);

        V1 = zeros(Nmax,1);
        V2 = zeros(Nmax,1);

        P1 = zeros(Nmax,1);
        P2 = zeros(Nmax,1);

        K1 = zeros(Nmax,1);
        K2 = zeros(Nmax,1);

        frictionLoss = zeros(Nmax,1);

        impactLoss = zeros(Nmax,1);


        X1(1) = x1;
        X2(1) = x2;

        V1(1) = v1;
        V2(1) = v2;

        P1(1) = m1*v1;
        P2(1) = m2*v2;

        K1(1) = 0.5*m1*v1^2;
        K2(1) = 0.5*m2*v2^2;


        initialMomentum = ...
            P1(1)+P2(1);

        initialEnergy = ...
            K1(1)+K2(1);


        totalFrictionLoss = 0;

        totalImpactLoss = 0;


        collisionOccurred = false;


        contactDistance = 0.65;


        target = collisionStopValue.Value;


        n = 1;


        while time(n) < tMax

            n = n+1;


            tPrev = time(n-1);

            currentDt = ...
                min(dt,tMax-tPrev);


            oldX1 = x1;
            oldX2 = x2;

            oldV1 = v1;
            oldV2 = v2;


            v1Free = ...
                applyFriction(v1,mu,g,currentDt);

            v2Free = ...
                applyFriction(v2,mu,g,currentDt);


            x1New = ...
                x1+0.5*(v1+v1Free)*currentDt;

            x2New = ...
                x2+0.5*(v2+v2Free)*currentDt;


            dx1 = ...
                x1New-x1;

            dx2 = ...
                x2New-x2;


            totalFrictionLoss = ...
                totalFrictionLoss + ...
                mu*m1*g*abs(dx1) + ...
                mu*m2*g*abs(dx2);


            x1 = x1New;
            x2 = x2New;

            v1 = v1Free;
            v2 = v2Free;


            relativePosition = ...
                x2-x1;


            direction = ...
                sign(relativePosition);


            if direction == 0

                direction = 1;

            end


            closingSpeed = ...
                (v1-v2)*direction;


            touching = ...
                abs(relativePosition) <= ...
                contactDistance;


            if ~collisionOccurred && ...
                    touching && ...
                    closingSpeed > 0


                collisionOccurred = true;


                midpoint = ...
                    0.5*(x1+x2);


                x1 = midpoint - ...
                    direction*contactDistance/2;

                x2 = midpoint + ...
                    direction*contactDistance/2;


                u1 = v1;
                u2 = v2;


                impactKBefore = ...
                    0.5*m1*u1^2 + ...
                    0.5*m2*u2^2;


                v1 = ...
                    ((m1-e*m2)*u1 + ...
                    (1+e)*m2*u2) ...
                    /(m1+m2);


                v2 = ...
                    ((m2-e*m1)*u2 + ...
                    (1+e)*m1*u1) ...
                    /(m1+m2);


                impactKAfter = ...
                    0.5*m1*v1^2 + ...
                    0.5*m2*v2^2;


                totalImpactLoss = ...
                    totalImpactLoss + ...
                    max( ...
                    impactKBefore-impactKAfter, ...
                    0);

            end


            time(n) = ...
                tPrev+currentDt;


            X1(n) = x1;
            X2(n) = x2;

            V1(n) = v1;
            V2(n) = v2;

            P1(n) = m1*v1;
            P2(n) = m2*v2;

            K1(n) = 0.5*m1*v1^2;
            K2(n) = 0.5*m2*v2^2;

            frictionLoss(n) = ...
                totalFrictionLoss;

            impactLoss(n) = ...
                totalImpactLoss;


            shouldStop = false;


            switch collisionStop.Value

                case 'Object 1 Position'

                    shouldStop = crossedValue( ...
                        oldX1,x1,target);


                case 'Object 2 Position'

                    shouldStop = crossedValue( ...
                        oldX2,x2,target);


                case 'Object 1 Velocity'

                    shouldStop = crossedValue( ...
                        oldV1,v1,target);


                case 'Object 2 Velocity'

                    shouldStop = crossedValue( ...
                        oldV2,v2,target);

            end


            if shouldStop

                break;

            end

        end


        time = time(1:n);

        X1 = X1(1:n);
        X2 = X2(1:n);

        V1 = V1(1:n);
        V2 = V2(1:n);

        P1 = P1(1:n);
        P2 = P2(1:n);

        K1 = K1(1:n);
        K2 = K2(1:n);

        frictionLoss = ...
            frictionLoss(1:n);

        impactLoss = ...
            impactLoss(1:n);


        totalP = ...
            P1+P2;

        totalK = ...
            K1+K2;


        animateCollision( ...
            time,X1,X2);



        cla(posAx);

        hold(posAx,'on');

        plot(posAx,time,X1, ...
            '-', ...
            'Color',NAVY, ...
            'LineWidth',2.3);

        plot(posAx,time,X2, ...
            '-', ...
            'Color',BLUE, ...
            'LineWidth',2.3);

        hold(posAx,'off');


        styleTitle(posAx,'POSITION');

        styleXAxis(posAx);

        styleYAxis(posAx,'Position [m]');


        lgd = legend(posAx, ...
            {'Object 1','Object 2'}, ...
            'Location','best');

        lgd.Box = 'off';
        lgd.FontName = FONT;
        lgd.FontSize = 12;
        lgd.FontWeight = 'normal';
        lgd.TextColor = BLACK;



        cla(speedAx);

        hold(speedAx,'on');

        plot(speedAx,time,abs(V1), ...
            '-', ...
            'Color',NAVY, ...
            'LineWidth',2.3);

        plot(speedAx,time,abs(V2), ...
            '-', ...
            'Color',BLUE, ...
            'LineWidth',2.3);

        hold(speedAx,'off');


        styleTitle(speedAx,'SPEED');

        styleXAxis(speedAx);

        styleYAxis(speedAx,'Speed [m/s]');


        lgd = legend(speedAx, ...
            {'Object 1','Object 2'}, ...
            'Location','best');

        lgd.Box = 'off';
        lgd.FontName = FONT;
        lgd.FontSize = 12;
        lgd.FontWeight = 'normal';
        lgd.TextColor = BLACK;



        cla(momentumAx);

        hold(momentumAx,'on');

        plot(momentumAx,time,P1, ...
            '-', ...
            'Color',NAVY, ...
            'LineWidth',2.2);

        plot(momentumAx,time,P2, ...
            '-', ...
            'Color',BLUE, ...
            'LineWidth',2.2);

        plot(momentumAx,time,totalP, ...
            '--', ...
            'Color',BLACK, ...
            'LineWidth',2.3);

        hold(momentumAx,'off');


        styleTitle(momentumAx,'MOMENTUM');

        styleXAxis(momentumAx);

        styleYAxis( ...
            momentumAx, ...
            'Momentum [kg*m/s]');


        lgd = legend(momentumAx, ...
            {'p1','p2','Total momentum'}, ...
            'Location','best');

        lgd.Box = 'off';
        lgd.FontName = FONT;
        lgd.FontSize = 12;
        lgd.FontWeight = 'normal';
        lgd.TextColor = BLACK;



        cla(energyAx);

        hold(energyAx,'on');

        plot(energyAx,time,K1, ...
            '-', ...
            'Color',NAVY, ...
            'LineWidth',2.4);

        plot(energyAx,time,K2, ...
            '-', ...
            'Color',BLUE, ...
            'LineWidth',2.4);

        plot(energyAx,time,totalK, ...
            '--', ...
            'Color',BLACK, ...
            'LineWidth',2.2);

        plot(energyAx,time, ...
            frictionLoss+impactLoss, ...
            ':', ...
            'Color',GRAY, ...
            'LineWidth',2.4);

        hold(energyAx,'off');


        styleTitle(energyAx,'ENERGY');

        styleXAxis(energyAx);

        styleYAxis(energyAx,'Energy [J]');


        lgd = legend(energyAx, ...
            {'Object 1 KE', ...
             'Object 2 KE', ...
             'Total KE', ...
             'Energy lost'}, ...
            'Location','best');

        lgd.Box = 'off';
        lgd.FontName = FONT;
        lgd.FontSize = 12;
        lgd.FontWeight = 'normal';
        lgd.TextColor = BLACK;



        ledger.Value = {
            'COLLISION RESULTS'
            ''
            sprintf('x1i = %.3f m',X1(1))
            sprintf('x1f = %.3f m',X1(end))
            sprintf('v1i = %.3f m/s',V1(1))
            sprintf('v1f = %.3f m/s',V1(end))
            ''
            sprintf('x2i = %.3f m',X2(1))
            sprintf('x2f = %.3f m',X2(end))
            sprintf('v2i = %.3f m/s',V2(1))
            sprintf('v2f = %.3f m/s',V2(end))
            ''
            sprintf('Pi = %.3f kg*m/s',initialMomentum)
            sprintf('Pf = %.3f kg*m/s',totalP(end))
            sprintf('KEi = %.3f J',initialEnergy)
            sprintf('KEf = %.3f J',totalK(end))
            ''
            'Momentum is conserved during impact.'
            'KE is conserved only for elastic impact.'
            'Friction and inelastic impact transform energy.'
            };

    end


    function vNew = applyFriction(v,mu,g,dt)

        if abs(v) < 1e-10 || mu == 0

            vNew = v;

            return;

        end


        accelFriction = ...
            -mu*g*sign(v);


        proposed = ...
            v+accelFriction*dt;


        if sign(proposed) ~= sign(v)

            vNew = 0;

        else

            vNew = proposed;

        end

    end


    function animateCollision(time,X1,X2)

        cla(simAx);


        minX = ...
            min([X1(:);X2(:)]);

        maxX = ...
            max([X1(:);X2(:)]);


        margin = ...
            max(1,0.15*(maxX-minX+1));


        xlim(simAx, ...
            [minX-margin maxX+margin]);

        ylim(simAx,[-0.4 1.35]);


        hold(simAx,'on');


        plot(simAx, ...
            [minX-margin maxX+margin], ...
            [0 0], ...
            'Color',BLACK, ...
            'LineWidth',2.5);


        blockW = 0.60;
        blockH = 0.60;


        b1 = rectangle(simAx, ...
            'Position', ...
            [X1(1)-blockW/2 0 blockW blockH], ...
            'FaceColor',NAVY, ...
            'EdgeColor',BLACK, ...
            'LineWidth',1.5);


        b2 = rectangle(simAx, ...
            'Position', ...
            [X2(1)-blockW/2 0 blockW blockH], ...
            'FaceColor',BLUE, ...
            'EdgeColor',BLACK, ...
            'LineWidth',1.5);


        text1 = text(simAx, ...
            X1(1), ...
            0.78, ...
            'Object 1', ...
            'Color',NAVY, ...
            'HorizontalAlignment','center', ...
            'FontName',FONT, ...
            'FontSize',14, ...
            'FontWeight','bold');


        text2 = text(simAx, ...
            X2(1), ...
            0.78, ...
            'Object 2', ...
            'Color',BLUE, ...
            'HorizontalAlignment','center', ...
            'FontName',FONT, ...
            'FontSize',14, ...
            'FontWeight','bold');


        timerText = text(simAx, ...
            mean([minX maxX]), ...
            1.15, ...
            't = 0.00 s', ...
            'Color',BLACK, ...
            'HorizontalAlignment','center', ...
            'FontName',FONT, ...
            'FontSize',15, ...
            'FontWeight','bold');


        styleTitle(simAx,'1D COLLISION');


        xlabel(simAx,'Position [m]', ...
            'FontName',FONT, ...
            'FontSize',14, ...
            'FontWeight','bold', ...
            'Color',BLACK, ...
            'Interpreter','none');


        yticks(simAx,[]);


        hold(simAx,'off');


        frameCount = ...
            min(150,length(time));


        frameIndices = ...
            unique(round(linspace( ...
            1,length(time),frameCount)));


        for k = frameIndices

            b1.Position = ...
                [X1(k)-blockW/2 ...
                 0 ...
                 blockW ...
                 blockH];


            b2.Position = ...
                [X2(k)-blockW/2 ...
                 0 ...
                 blockW ...
                 blockH];


            text1.Position(1) = ...
                X1(k);

            text2.Position(1) = ...
                X2(k);


            timerText.String = ...
                sprintf( ...
                't = %.2f s', ...
                time(k));


            drawnow limitrate;

        end

    end


    function tf = crossedValue(previous,current,target)

        tolerance = 1e-9;


        tf = ...
            abs(current-target) < tolerance || ...
            (previous-target)*(current-target) <= 0;

    end

end