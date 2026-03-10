import React from 'react';

/**
 * A simple informational card used on the "Why Invest" page.
 *
 * props:
 *  - icon: JSX element or string to render in the icon slot (typically an SVG or emoji)
 *  - title: short heading above the value
 *  - value: main statistic or number to highlight
 */
export default function InfoCard({ icon, title, value }) {
  return (
    <div className="info-card">
      <div className="info-card__icon">{icon}</div>
      <div className="info-card__title">{title}</div>
      <div className="info-card__value">{value}</div>
    </div>
  );
}
