#!/usr/bin/env python3
import json
try:
    from wayfire import WayfireSocket
except ImportError:
    print('{"text": "WS: N/A", "tooltip": "wayfire library not available"}', flush=True)
    exit(0)

def get_current_workspace():
    try:
        socket = WayfireSocket()

        # Get focused output info
        output = socket.get_focused_output()

        if output and 'workspace' in output:
            ws = output['workspace']
            if 'x' in ws and 'y' in ws:
                # Convert to 1-based indexing for display
                x_display = ws['x'] + 1
                y_display = ws['y'] + 1

                # If it's a single row (grid_height = 1), just show workspace number with icon
                if ws.get('grid_height', 1) == 1:
                    return f"🖥️ {x_display}"
                else:
                    return f"🖥️ {x_display},{y_display}"

        return "N/A"

    except Exception as e:
        return "ERR"

if __name__ == "__main__":
    current = get_current_workspace()
    result = {
        "text": current,
        "tooltip": f"Current workspace: {current.replace('🖥️ ', '')}"
    }
    print(json.dumps(result), flush=True)