//
//  Shaders.metal
//  SwiftUI+Metal
//
//  Created by MarkG on 17/01/2024.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

[[ stitchable ]] float2 pixellate(float2 position, float size, float2 magnifierPosition, float2 magnifierSize) {
    if (
        position.x >= magnifierPosition.x && position.x <= magnifierPosition.x + magnifierSize.x
            && position.y >= magnifierPosition.y && position.y <= magnifierPosition.y + magnifierSize.y
    ) {
        float2 pixellatedPosition = round(position / size) * size;
        return pixellatedPosition;
    } else {
        return position;
    }
}
