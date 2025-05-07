import os
import sys
from caret_analyze import Application, Architecture, Lttng
from caret_analyze.plot import Plot

if len(sys.argv) < 2:
    print("Usage: python caret_plot.py <log_dir>")
    sys.exit(1)

log_dir = sys.argv[1]
trace_path = os.path.join(log_dir, "autoware_launch_trace")
arch_path = os.path.join(log_dir, "architecture.yaml")

# Load recorded data
lttng = Lttng(trace_path)
# Load an Architecture object
arch = Architecture("yaml", arch_path)
# Map the architecture object to the recorded data
app = Application(arch, lttng)


# Get only the callbacks from the simulator node
sim_node = app.get_node("/simulation/simple_planning_simulator")
sim_callbacks = sim_node.callbacks

# Plot only those
plot = Plot.create_latency_timeseries_plot(sim_callbacks)
plot.save(log_dir + "/latency_simulator.html", full_legends=True)
