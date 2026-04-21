//
//  ReadMoreStyle.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/22.
//

import Raptor

struct ReadMoreStyle: Style {
    func style(content: Content, environment: EnvironmentConditions) -> Content {
        let theme = environment.arknights

        return content
            // 文字颜色（反色）
            .foregroundStyle(theme.palette.surface)

            // 背景
            .background(theme.palette.accent)

            // 字体
            .font(.custom("BenderLight", size: theme.typography.smallSize, weight: .semibold))

            // block + 靠右
            .style(Property.display(.block))

            // 🔥 关键：往上“顶”
            .style(Property.marginTop(.px(-21)))

            // 🔥 关键：padding（左边更大）
            .style(Property.paddingTop(.px(3)))
            .style(Property.paddingRight(.px(10)))
            .style(Property.paddingBottom(.px(3)))
            .style(Property.paddingLeft(.px(40)))
    }
}
