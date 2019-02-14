within IDEAS.Utilities.Time2.Validation;
model CalendarTimeMonthsPlus
  "Validation model for the calendar time model with start time slightly higher than the full hour"
  extends IDEAS.Utilities.Time2.Validation.CalendarTimeMonths;

  annotation (
    __Dymola_Commands(file="Resources/Scripts/Dymola/Utilities/Time/Validation/CalendarTimeMonthsPlus.mos"
        "Simulate and plot"),
  Documentation(
    info="<html>
<p>
This model validates the use of the
<a href=\"modelica://IDEAS.Utilities.Time2.CalendarTime\">
IDEAS.Utilities.Time2.CalendarTime</a>.
It is identical to
<a href=\"modelica://IDEAS.Utilities.Time2.Validation.CalendarTimeMonths\">
IDEAS.Utilities.Time2.Validation.CalendarTimeMonths</a>
except that the start and end time are different.
</p>
</html>",
revisions="<html>
<ul>
<li>
September 14, 2016, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
    experiment(StartTime=172801, Tolerance=1e-6, StopTime=345601));
end CalendarTimeMonthsPlus;
