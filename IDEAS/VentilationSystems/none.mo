within IDEAS.VentilationSystems;
model None "No ventilation"
  extends IDEAS.VentilationSystems.Ideal(m_flow_val(final k=0));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end None;
